---
title:  init 功能与运行分析
tags:
tagline: Linux启动完成阶段第一进程
---

# Init 的主要作用

本程序是Linux完成内核加载后的第一个进程, 主要进行linux
级首个上下文的设置(linux属性体系), 基础服务的启动与状态
管理(重新启动, 状态监视), 系统属性变化后的状态重置.


## 涉及的框架

* selinux
    * 针对所有的安全隐患API进行备案与调用审计
    * 只有特定应用在特定权限下, 才能运行特定API
* 业务数据存储的整体结构
    * 属性数据存储: 基本的文本文件
* 提供的业务流程
    * 运行结构
    * 支持的命令
    * Service的状态维护
* 权限管理
    * socket 与 ctl
* 业务通信
    * linux下的通信机制: socket
* rc文件的分析与处理流程
    * 专用的文法与解析程序

# 主要业务流程

## Init启动的前置条件
1. 设备上电启动
2. uboot完成第一步引导并进行初始化(boot.img)
    1. 加载Ramdisk到内存(完成根文件系统的设置)
    2. 加载内核到内存(kernel)
    3. 引导到内核
3. 内核完成硬件初始化工作与系统核心数据的初始化工作
4. 内核完成工作后, 启动init程序

## Init主要业务

### 下述为非charger状态
1. 创建Android需要的根文件系统相关节点
2. init状态初始化
    1. klog
    2. property
    3. 内核启动过程相关状态保护
        1. 获取hardware名称
        2. 设置基础系统相关的属性
            1. ro.serialno
            2. ro.bootmode
            3. ro.baseband
            4. ro.bootloader
            5. ro.hardware
            6. ro.revision
    4. selinux
3. (!charger)基本属性加载: PROP_PATH_RAMDISK_DEFAULT = /default.prop
4. 加载Config
    1. 以init.rc为入口, 分析init内部指令
5. Action 顺序加载(统一存放在action_queue)(O: 一个前置条件下的一组指令on xxx, A:具体的一个Action)
    1. O:early-init
    2. A:wait_for_coldboot_done
    3. A:mix_hwrng_into_linux_rng
    4. A:keychord_init
    5. A:console_init
    6. O:init
    7. !charger:
        1. O:early-fs
        2. O:fs
        3. O:post-fs
        4. O:post-fs-data
    8. A:mix_hwrng_into_linux_rng
    9. A:property_service_init
        1. 加载属性数据

            ```c
            #define PROP_PATH_RAMDISK_DEFAULT  "/default.prop"
            #define PROP_PATH_SYSTEM_BUILD     "/system/build.prop"
            #define PROP_PATH_SYSTEM_DEFAULT   "/system/default.prop"
            #define PROP_PATH_LOCAL_OVERRIDE   "/data/local.prop"
            #define PROP_PATH_FACTORY          "/factory/factory.prop"
            load_properties_from_file(PROP_PATH_SYSTEM_BUILD);     // /system/build.prop
            load_properties_from_file(PROP_PATH_SYSTEM_DEFAULT);   // /system/default.prop
            load_override_properties(); //PROP_PATH_LOCAL_OVERRIDE // /data/local.prop
            load_persistent_properties();                          // /data/property/*
            ```

    10. A:signal_init
    11. A:check_startup
    12. !charger:
        1. O:early-boot
        2. O:boot
    13. A:queue_property_triggers (properies条件触发的相关Action)

## Init 程序的内部数据组织结构

### 数据要求

```c
//bionic/libc/include/sys/system_properties.h
//Property key max length = 32 - 1(\0) = 31
#define PROP_NAME_MAX   32
//Property value max length = 92 - 1(\0) = 91
#define PROP_VALUE_MAX  92
```

### 整体关系


```

action ---1---N---> commands

service_list
    |
    `---+---> service1 ---> onrestart-action
        |(linked list: slist )
        +---> service2
        :
        :
        :


action_list
    |
    `---+---> action1
        |(linked list: alist )
        +---> action2
        :
        :
        :

action_queue
    |
    `---+---> action1
        |(linked list: qlist )
        +---> action2
        :
        :
        :

import_list
```

### 加载顺序
1. 一个文件加载完成后, 再次循环加载import 的文件(统一存储在service_list,action_list)
    * 共用`service_list, action_list`
2. 按顺序组织相关action
    * 存储在`action_queue`中

## 属性服务的结构

### init自身启动时设置有效区间

0. property: name=value
1. 如果不存在则直接添加(add(name,value))
2. 如果存在
    * ro.xxx.xx 不允许修改(return -1)
    * 其它则直接Update(update(name,value))
3. net.xxx == name
    * update('net.change',name)(name!='net.change')
    * return 0 (name=='net.change')
4. persist.xxx == name
    * save value to persistent_data_area
5. 触发 property 改变时的action进行调用

### 通过系统接口进行property设置

* 通过socket的通道进行通信
* 针对ctl等控制类的数据,会检查完权限后, 进行服务的start/stop/restart 操作
* 针对其它property, 会有一个列表, 检查是否有权限进行设置

### Android系统级对于property的设置

与系统流程相关的主要property:
* Android系统启动完成后,通知系统
    * sys.boot_completed=1
    * dev.bootcomplete=1
* 系统重启与关机
    * ro.runtime.firstboot=time
    * ShutdownThread.REBOOT_SAFEMODE_PROPERTY
    * sys.powerctl=shutdown/reboot,reason
    * SHUTDOWN_ACTION_PROPERTY=reason
    * REBOOT_SAFEMODE_PROPERTY
* 系统环境
    * user.language
    * user.region
    * persist.sys.language
    * persist.sys.country
    * persist.sys.localevar
    * persist.sys.dalvik.vm.lib
    * selinux.reload_policy
    * persist.selinux.enforcing
    * TIMEZONE_PROPERTY
* 系统调试与开发
    * ctl.start bugreport
    * StrictMode.VISUAL_PROPERTY
    * persist.sys.profiler_ms
* 系统设备
    * SYSTEM_PROP_DISABLE_CAMERA
    * USB
    * 网络
        * net.hostname
        * net.dns
        * PROP_QTAGUID_ENABLED : 用于内核级网络流量统计
        * GSM
        * UICC
        * SIM CARD
        * net.ppp.reset-by-timeout
        * CDMA
        * SMS

Android 中的属性服务调用位置:

```shell
./base/cmds/am/src/com/android/commands/am/Am.java:            SystemProperties.set("dalvik.vm.extra-opts", props);
./base/services/java/com/android/server/DevicePolicyManagerService.java:                SystemProperties.set(SYSTEM_PROP_DISABLE_CAMERA, value);
./base/services/java/com/android/server/am/ProcessList.java:            SystemProperties.set("sys.sysctl.extra_free_kbytes", Integer.toString(reserve));
./base/services/java/com/android/server/am/ActivityManagerService.java:                SystemProperties.set("sys.boot_completed", "1");
./base/services/java/com/android/server/am/ActivityManagerService.java:                SystemProperties.set("dev.bootcomplete", "1");
./base/services/java/com/android/server/am/ActivityManagerService.java:        SystemProperties.set("ctl.start", "bugreport");
./base/services/java/com/android/server/am/ActivityManagerService.java:        SystemProperties.set(Settings.Global.DEVELOPMENT_FORCE_RTL, forceRtl ? "1":"0");
./base/services/java/com/android/server/am/ActivityManagerService.java:            SystemProperties.set("user.language", l.getLanguage());
./base/services/java/com/android/server/am/ActivityManagerService.java:            SystemProperties.set("user.region", l.getCountry());
./base/services/java/com/android/server/am/ActivityManagerService.java:            SystemProperties.set("persist.sys.language", l.getLanguage());
./base/services/java/com/android/server/am/ActivityManagerService.java:            SystemProperties.set("persist.sys.country", l.getCountry());
./base/services/java/com/android/server/am/ActivityManagerService.java:            SystemProperties.set("persist.sys.localevar", l.getVariant());
./base/services/java/com/android/server/wm/WindowManagerService.java:        SystemProperties.set(StrictMode.VISUAL_PROPERTY, value);
./base/services/java/com/android/server/wm/WindowManagerService.java:                SystemProperties.set(ShutdownThread.REBOOT_SAFEMODE_PROPERTY, "");
./base/services/java/com/android/server/BootReceiver.java:            SystemProperties.set("ro.runtime.firstboot", now);
./base/services/java/com/android/server/usb/UsbDeviceManager.java:                    SystemProperties.set("sys.usb.config", mDefaultFunctions);
./base/services/java/com/android/server/usb/UsbDeviceManager.java:                    SystemProperties.set("persist.service.adb.enable", "");
./base/services/java/com/android/server/usb/UsbDeviceManager.java:            SystemProperties.set("sys.usb.config", config);
./base/services/java/com/android/server/usb/UsbDeviceManager.java:                    SystemProperties.set("persist.sys.usb.config", functions);
./base/services/java/com/android/server/usb/UsbDeviceManager.java:                        SystemProperties.set("persist.sys.usb.config", mDefaultFunctions);
./base/services/java/com/android/server/SystemServer.java:        SystemProperties.set("persist.sys.dalvik.vm.lib",
./base/services/java/com/android/server/power/PowerManagerService.java:        SystemProperties.set("sys.powerctl", "shutdown");
./base/services/java/com/android/server/power/PowerManagerService.java:        SystemProperties.set("sys.powerctl", "reboot," + reason);
./base/services/java/com/android/server/power/ShutdownThread.java:            SystemProperties.set(SHUTDOWN_ACTION_PROPERTY, reason);
./base/services/java/com/android/server/power/ShutdownThread.java:            SystemProperties.set(REBOOT_SAFEMODE_PROPERTY, "1");
./base/services/java/com/android/server/ConnectivityService.java:                SystemProperties.set("net.hostname", name);
./base/services/java/com/android/server/ConnectivityService.java:                SystemProperties.set(key, value); //net.dns
./base/services/java/com/android/server/ConnectivityService.java:                SystemProperties.set(key, "");    //net.dns
./base/services/java/com/android/server/NetworkManagementService.java:        SystemProperties.set(PROP_QTAGUID_ENABLED, mBandwidthControlEnabled ? "1" : "0");
./base/services/java/com/android/server/SamplingProfilerService.java:            SystemProperties.set("persist.sys.profiler_ms", samplingProfilerMs.toString());
./base/services/java/com/android/server/updates/SELinuxPolicyInstallReceiver.java:        SystemProperties.set("selinux.reload_policy", "1");
./base/services/java/com/android/server/updates/SELinuxPolicyInstallReceiver.java:            SystemProperties.set("persist.selinux.enforcing", mode);
./base/services/java/com/android/server/AlarmManagerService.java:                    SystemProperties.set(TIMEZONE_PROPERTY, zone.getID());
./opt/telephony/src/java/com/android/internal/telephony/gsm/GSMPhone.java:        SystemProperties.set(TelephonyProperties.CURRENT_ACTIVE_PHONE,
./opt/telephony/src/java/com/android/internal/telephony/gsm/GsmServiceStateTracker.java:                SystemProperties.set("gsm.nitz.time", String.valueOf(c.getTimeInMillis()));
./opt/telephony/src/java/com/android/internal/telephony/uicc/RuimRecords.java:            SystemProperties.set(PROPERTY_ICC_OPERATOR_ALPHA, mSpn);
./opt/telephony/src/java/com/android/internal/telephony/uicc/RuimRecords.java:            SystemProperties.set(PROPERTY_ICC_OPERATOR_NUMERIC, operator);
./opt/telephony/src/java/com/android/internal/telephony/uicc/RuimRecords.java:            SystemProperties.set(PROPERTY_ICC_OPERATOR_ISO_COUNTRY,
./opt/telephony/src/java/com/android/internal/telephony/uicc/SIMRecords.java:        SystemProperties.set(PROPERTY_ICC_OPERATOR_NUMERIC, null);
./opt/telephony/src/java/com/android/internal/telephony/uicc/SIMRecords.java:        SystemProperties.set(PROPERTY_ICC_OPERATOR_ALPHA, null);
./opt/telephony/src/java/com/android/internal/telephony/uicc/SIMRecords.java:        SystemProperties.set(PROPERTY_ICC_OPERATOR_ISO_COUNTRY, null);
./opt/telephony/src/java/com/android/internal/telephony/uicc/SIMRecords.java:            SystemProperties.set(PROPERTY_ICC_OPERATOR_NUMERIC, operator);
./opt/telephony/src/java/com/android/internal/telephony/uicc/SIMRecords.java:            SystemProperties.set(PROPERTY_ICC_OPERATOR_ISO_COUNTRY,
./opt/telephony/src/java/com/android/internal/telephony/uicc/SIMRecords.java:                    SystemProperties.set(PROPERTY_ICC_OPERATOR_ALPHA, mSpn);
./opt/telephony/src/java/com/android/internal/telephony/uicc/SIMRecords.java:                    SystemProperties.set(PROPERTY_ICC_OPERATOR_ALPHA, mSpn);
./opt/telephony/src/java/com/android/internal/telephony/uicc/SIMRecords.java:                    SystemProperties.set(PROPERTY_ICC_OPERATOR_ALPHA, mSpn);
./opt/telephony/src/java/com/android/internal/telephony/uicc/IccCardProxy.java:            SystemProperties.set(PROPERTY_SIM_STATE, mExternalState.toString());
./opt/telephony/src/java/com/android/internal/telephony/dataconnection/DcTracker.java:        SystemProperties.set("net.ppp.reset-by-timeout", String.valueOf(reset+1));
./opt/telephony/src/java/com/android/internal/telephony/dataconnection/DcTracker.java:                    SystemProperties.set(PUPPET_MASTER_RADIO_STRESS_TEST, "true");
./opt/telephony/src/java/com/android/internal/telephony/dataconnection/DcTracker.java:                    SystemProperties.set(PUPPET_MASTER_RADIO_STRESS_TEST, "false");
./opt/telephony/src/java/com/android/internal/telephony/dataconnection/DcTracker.java:            SystemProperties.set(PUPPET_MASTER_RADIO_STRESS_TEST, "false");
./opt/telephony/src/java/com/android/internal/telephony/dataconnection/DcTrackerBase.java:                SystemProperties.set(RADIO_RESET_PROPERTY, "true");
./opt/telephony/src/java/com/android/internal/telephony/cdma/SmsMessage.java:        SystemProperties.set(TelephonyProperties.PROPERTY_CDMA_MSG_ID, nextMsgId);
./opt/telephony/src/java/com/android/internal/telephony/cdma/CDMAPhone.java:        SystemProperties.set(TelephonyProperties.CURRENT_ACTIVE_PHONE,
./opt/telephony/src/java/com/android/internal/telephony/cdma/CdmaServiceStateTracker.java:                SystemProperties.set("gsm.nitz.time", String.valueOf(c.getTimeInMillis()));
```

