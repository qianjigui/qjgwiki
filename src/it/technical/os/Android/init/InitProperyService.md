---
title: 基于init属性体系的系统开发实践
tags: SavingData
tagline: 数据持久化的一种方法
---

# 问题

在Android系统开发中, 如何通过类似Linux init的属性服务进行native 程序的开关与数据存储?
在Android定制的Linux 服务程序中, 又有哪些生命周期的要求与数据存储的限制?

在Linux系统中, 首先被启动的是存放在boot-image中的init进程.
该进程在初始化时, 会建立一个通过epoll进行进程间通信的属性管理服务, 然后进行init配置的加载与基础属性数据的加载.
本文主要讨论这个属性管理服务.

# Hello world

通过简单的adb接入系统之后, 可以通过`getprop`与`setprop`进行数据的读写.

    #adb shell
    shell@maguro:/ $ getprop ro.build.version.release
    4.3
    shell@maguro:/ $ setprop ro.debug.helloworld true
    shell@maguro:/ $ getprop ro.debug.helloworld
    true


具体的API的说明:

1. `getprop [key]`: 获取指定key的属性值，如果不带参数，显示系统所有的属性值
2. `setprop [key] [value]`: 设置指定key的属性值
3. `watchprops`

# 具体服务使用分析

**下述分析基于代码AOSP4.4**

## 属性的限制

让我们做一些边界测试(大数据), 看看这些API的限制在哪里.

    #adb shell
    shell@maguro:/ $ setprop ro.debug.helloworld.12345678901 true
    shell@maguro:/ $ getprop ro.debug.helloworld.12345678901
    true
    shell@maguro:/ $ setprop ro.debug.helloworld.123456789012 true
    could not set property

部分属性`ro.debug.helloworld.123456789012`, 没有设置成功.
与各种程序API一样, 对于参数也有明确的限制:

1. `[key]`:
    * Naming命名要求`is_legal_property_name(msg.name, strlen(msg.name))`
        * 1<=总长度<=31
        * 开头与结尾不能是`.`
        * 不能有连续的`.`
        * 字符组成: `[a-zA-Z0-9\_\-\.]`
    * Permissions权限要求
        * 服务控制类(以`ctl.`开头的key) `check_control_perms`
            * system/root 用户有权
            * 该服务的用户/用户组有权
        * 数据类`check_perms(msg.name, cr.uid, cr.gid, source_ctx)`
            * 不同开头的属性需要具有如下的用户权限要求

                    { "net.rmnet0.",      AID_RADIO,    0 },
                    { "net.gprs.",        AID_RADIO,    0 },
                    { "net.ppp",          AID_RADIO,    0 },
                    { "net.qmi",          AID_RADIO,    0 },
                    { "net.lte",          AID_RADIO,    0 },
                    { "net.cdma",         AID_RADIO,    0 },
                    { "ril.",             AID_RADIO,    0 },
                    { "gsm.",             AID_RADIO,    0 },
                    { "persist.radio",    AID_RADIO,    0 },
                    { "net.dns",          AID_RADIO,    0 },
                    { "sys.usb.config",   AID_RADIO,    0 },
                    { "net.",             AID_SYSTEM,   0 },
                    { "dev.",             AID_SYSTEM,   0 },
                    { "runtime.",         AID_SYSTEM,   0 },
                    { "hw.",              AID_SYSTEM,   0 },
                    { "sys.",             AID_SYSTEM,   0 },
                    { "sys.powerctl",     AID_SHELL,    0 },
                    { "service.",         AID_SYSTEM,   0 },
                    { "wlan.",            AID_SYSTEM,   0 },
                    { "bluetooth.",       AID_BLUETOOTH,   0 },
                    { "dhcp.",            AID_SYSTEM,   0 },
                    { "dhcp.",            AID_DHCP,     0 },
                    { "debug.",           AID_SYSTEM,   0 },
                    { "debug.",           AID_SHELL,    0 },
                    { "log.",             AID_SHELL,    0 },
                    { "service.adb.root", AID_SHELL,    0 },
                    { "service.adb.tcp.port", AID_SHELL,    0 },
                    { "persist.sys.",     AID_SYSTEM,   0 },
                    { "persist.service.", AID_SYSTEM,   0 },
                    { "persist.security.", AID_SYSTEM,   0 },
                    { "persist.service.bdroid.", AID_BLUETOOTH,   0 },
                    { "selinux."         , AID_SYSTEM,   0 },
                    { NULL, 0, 0 } 

2. `[value]`
    * Naming命名要求: 总长度<=91

            public class SystemProperties
            {
              public static final int PROP_NAME_MAX = 31;
              public static final int PROP_VALUE_MAX = 91;

3. 更多的权限要求: 增加了selinux后, 所有的操作还需要进行selinux的检查

## 特殊属性的功能

1. `ro.*` 只能被设置一次, 如果该属性已经存在, 后续设置无效. ReadOnly
2. `net.*` 网络属性被认为会触发DNS变更, 后续会再调用一个`net.change`的属性设置
3. `persist.*` 持久化的属性, 会在flash中保存一份
4. `selinux.reload_policy` 重新加载selinux policy
5. `ctl.*` 对具体的init服务进行控制: `stop/start/restart`
    * 这些具体的init服务名称以`init.svc.`开头

            shell@maguro:/ $ getprop | grep svc
            [init.svc.adbd]: [running]
            [init.svc.bootanim]: [stopped]
            [init.svc.debuggerd]: [running]
            [init.svc.drm]: [running]
            [init.svc.fRom]: [stopped]
            [init.svc.installd]: [running]
            [init.svc.keystore]: [running]
            [init.svc.media]: [running]
            [init.svc.netd]: [running]
            [init.svc.p2p_supplicant]: [running]
            [init.svc.pvrsrvctl]: [stopped]
            [init.svc.ril-daemon]: [running]
            [init.svc.sdcard]: [running]
            [init.svc.servicemanager]: [running]
            [init.svc.setup_fs]: [stopped]
            [init.svc.smc_pa_wvdrm]: [stopped]
            [init.svc.surfaceflinger]: [running]
            [init.svc.tf_daemon]: [running]
            [init.svc.ueventd]: [running]
            [init.svc.vold]: [running]
            [init.svc.zygote]: [running]

    * 具体操作方法: `setprop ctl.zygote restart`

## 属性变更与系统依赖

属性发生变更(添加, 重置), 会触发调用`propery_changed`.
此时, init进程会检查rc配置中`on properties`吻合的数据, 进行后续调用操作.

# 服务提供方式分析

## Native 层

### Demo

具体使用方法:

        #include <cutils/properties.h>

        //frameworks/native/services/surfaceflinger/SurfaceFlinger.cpp
        void SurfaceFlinger::bootFinished()
        {
            const nsecs_t now = systemTime();
            const nsecs_t duration = now - mBootTime;
            ALOGI("Boot is finished (%ld ms)", long(ns2ms(duration)) );
            mBootFinished = true;

                // wait patiently for the window manager death
            const String16 name("window");
            sp<IBinder> window(defaultServiceManager()->getService(name));
            if (window != 0) {
                window->linkToDeath(static_cast<IBinder::DeathRecipient*>(this));
            }
            
            // stop boot animation
            // formerly we would just kill the process, but we now ask it to exit so it
            // can choose where to stop the animation.
            property_set("service.bootanim.exit", "1");
        }
        
        
        // frameworks/base/cmds/bootanimation/BootAnimation.cpp
        #define EXIT_PROP_NAME "service.bootanim.exit"

        void BootAnimation::checkExit() {
            // Allow surface flinger to gracefully request shutdown
            char value[PROPERTY_VALUE_MAX];
            property_get(EXIT_PROP_NAME, value, "0");
            int exitnow = atoi(value);
            if (exitnow) {
                requestExit();
            }
        }

在这个使用场景中, surfaceflinger 通过 property 告诉 bootanimation 进行退出操作.
bootanimation通过 **轮询的方式** 查看property的数据, 最终判定是否退出.

### 接口特性

接口存在位置: `system/core/include/cutils/properties.h`
在源代码中有多种实现方式:

1. libc的接口: `HAVE_LIBC_SYSTEM_PROPERTIES`
2. property server 通信 `HAVE_SYSTEM_PROPERTY_SERVER`
3. SUPER-cheesy place-holder implementation for Win32 

通过编译调试发现, 最终使用的是 `No. 1` libc方式 `#include <sys/_system_properties.h>`.
具体实现在`bionic/libc/bionic/system_properties.c`中.

完整数据是存储在共享内存中, 各进程通过`mmap`的方式进行 **读取READ**.
但进行set时, 是通过与init-property-server进行socket通信完成的, 这里是 **同步操作** , 通过轮询检查poll端口状态的方式来确保调用完成.

在相关实现中, 我们发现其还提供了`update/add`等接口, 是否同样可以调用, 以逃脱权限的限制?
由于是通过Shared memory方式实现的, init是一号进程, 会创建并设置这块共享内存的读写权限(0444),
最终只有init具有写权限, 其它程序只有读权限.

        //init:
        init_property_area
            //libc
            __system_property_area_init
            map_prop_area_rw //mmap时具有READ&WRITE权限

        //other process
        //libc
        __libc_init_common
            __system_properties_init
            map_prop_area
                如果没有共享内存区域, 则通过 get_fd_from_env 进行查找, 具体是通过环境变量ANDROID_PROPERTY_WORKSPACE
                这个环境变量由init程序进行设置, 这样就解决了是init服务程序创建的属性服务空间.


## Java SDK 层

参见具体实现: `frameworks/base/core/java/android/os/SystemProperties.java`.
其关键调用进入了`native_set/native_get`等JNI接口中, 实际实现是`frameworks/base/core/jni/android_os_SystemProperties.cpp`其最后是与native接口一样, 依赖于cutils中的实现.

## 数据存储细节

如代码中描述实际存储使用的是一个混合二叉树, 其占内存的总大小是: `PA_SIZE=128*1024`.
其中每次申请一个新的property占用空间: `prop_info(92+4=98)+namelen(31)=130`, 最保守估算可以申请 **1024** 个property.

# 总结

1. 属性系统存储规格:
    * `1<=len(key)<=31`
    * `1<=len(value)<=91`
    * `man properties <= 1024`
2. 后续再考虑存储相关特性时, 关注可存储空间大小
3. 系统虽小, 但通过共享内存兼顾了读取的速度, 通过服务代理管理了权限与唯一性, 通过socket+epoll的方式又使得接口效率得到提高.

# 参考资料

* http://blog.csdn.net/new_abc/article/details/8020558
* http://blog.csdn.net/new_abc/article/details/8022555
