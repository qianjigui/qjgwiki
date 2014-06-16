---
title: Android系统编译User/Eng等状态
tags:
---

# ADB服务管理
目前网络上有各种应用会通过adb通道对系统进行静默安装应用. 例如: [App adb install](http://www.huxiu.com/article/35648/1.html).

Android系统针对adb有如下管理策略:
* 在4.2.2版本后,针对所有连接设备的应用都需要使用者在设备上进行确认.而且是分设备与MAC进行权限管理
* 在Android 4.2等设备上有针对adb管理的开发者模式. 通过该模式对adb debug权限进行管理
* Opensource的版本,针对eng/userdebug/user进行管理与放开adb权限

如果需要从系统编译与编译环境控制的角度处理, 可以通过如下property进行管理.
* build:
    * `ro.debuggable`
* system/core/rootdir/init.usb.rc
    * `sys.usb.config`包含`adb`选项(也是通过上面的编译系统一步步管理到这个参数的)

如果需要在Opensource上管理并检查这些选项可以通过如下方法:
* 查找与`ro.debuggable`相关在环境控制
     * 例如变量: `enable_target_debugging`
* 查找initrc中的相关权限改变
* 添加开发者模式进行管理
* 临时关闭adb看效果: 在root下运行命令: `stop adbd`

# 系统编译选项
下面的讨论基于标准Android 4.4代码.
## user/userdebug/eng

| Built Type | 具体影响 |
|------------|----------|
| eng          | This is the default flavor. A plain "make" is the same as "make eng". droid is an alias for eng.  Installs modules tagged with: eng, debug, user, and/or development.  Installs non-APK modules that have no tags specified.  Installs APKs according to the product definition files, in addition to tagged APKs. ` ro.secure=0 ro.debuggable=1 ro.kernel.android.checkjni=1` adb is enabled by default. |
| user | "make user" This is the flavor intended to be the final release bits.  Installs modules tagged with user.  Installs non-APK modules that have no tags specified.  Installs APKs according to the product definition files; tags are ignored for APK modules.  `ro.secure=1 ro.debuggable=0` adb is disabled by default.  |
| userdebug | "make userdebug" The same as user, except: Also installs modules tagged with debug.  `ro.debuggable=1` adb is enabled by default.  |

### Eng
编译时的默认选项

### User
最后用于产品生成的发布版本

### UserDebug
与User版本相同,　添加adb服务

## 关键property分析

### `ro.secure`
#### 源代码涉及的修改
```
./frameworks/base/services/java/com/android/server/wm/WindowManagerService.java:    private static final String SYSTEM_SECURE = "ro.secure";
./frameworks/base/core/java/android/net/http/AndroidHttpClient.java:                // Never print auth token -- we used to check ro.secure=0 to
./bionic/libc/bionic/system_properties.c: * binary tree.  For instance, "ro.secure"="1" could be stored as follows:
./bionic/libc/bionic/system_properties.c: *                     v        v            v     +-------->| ro.secure |
./build/core/main.mk:  ADDITIONAL_DEFAULT_PROPERTIES += ro.secure=1
./build/core/main.mk:  ADDITIONAL_DEFAULT_PROPERTIES += ro.secure=0
./build/core/build-system.html:        <li><code>ro.secure=0</code>
./build/core/build-system.html:        <li><code>ro.secure=1</code>
./system/core/adb/adb.c:   /* run adbd in secure mode if ro.secure is set and
./system/core/adb/adb.c:        property_get("ro.secure", value, "1");
./system/core/adb/adb.c:            // don't run as root if ro.secure is set...
```

#### 具体作用总结
* build/xxx: 环境设置
* system/xxx/adb.c: 如果=1,`adb root`将无法成功. 还有其它的附加条件除外.
* WindowManagerService: 用于管理viewserver(Hierarchy Viewer) http://blog.csdn.net/michaelpp/article/details/12611787
* AndroidHttpClient: 在=1时,不会在log中dump auth token
* bionic/xxx/system_properties.c: 介绍properties存储结构时用的例子

### `ro.debuggable`
#### 源代码涉及的修改

```
./bootable/recovery/adb_install.cpp:    int len = property_get("ro.debuggable", value, NULL);
./bootable/recovery/etc/init.rc:on property:ro.debuggable=1
./build/core/build-system.html:        <li><code>ro.debuggable=0</code>
./build/core/build-system.html:        <li><code>ro.debuggable=1</code>
./build/core/build-system.html:        <li><code>ro.debuggable=1</code>
./build/core/main.mk:  ADDITIONAL_DEFAULT_PROPERTIES += ro.debuggable=0
./build/core/main.mk:  ADDITIONAL_DEFAULT_PROPERTIES += ro.debuggable=1
./build/tools/post_process_props.py:  # If ro.debuggable is 1, then enable adb on USB by default
./build/tools/post_process_props.py:  if prop.get("ro.debuggable") == "1":
./dalvik/docs/debugger.html:for all applications when the system property <code>ro.debuggable</code>
./dalvik/docs/debugger.html:is set to </code>1</code> (use <code>adb shell getprop ro.debuggable</code>
./device/samsung/manta/init.manta.rc:on property:ro.debuggable=1
./external/libnfc-nxp/Linux_x86/phDal4Nfc.c:    property_get("ro.debuggable", value, "");
./external/openssh/servconf.c:	/* Allow root login if ro.debuggable is set */
./external/openssh/servconf.c:	property_get("ro.debuggable", value, "");
./frameworks/av/services/audioflinger/AudioFlinger.cpp:    (void) property_get("ro.debuggable", value, "0");
./frameworks/base/core/java/android/net/SSLCertificateSocketFactory.java:        return "1".equals(SystemProperties.get("ro.debuggable")) &&
./frameworks/base/core/java/android/os/Build.java:            SystemProperties.getInt("ro.debuggable", 0) == 1;
./frameworks/base/core/java/com/android/internal/os/ZygoteConnection.java:        if ("1".equals(SystemProperties.get("ro.debuggable"))) {
./frameworks/base/core/java/com/android/internal/os/ZygoteConnection.java:     * If "ro.debuggable" is "1", all apps are debuggable. Otherwise,
./frameworks/base/policy/src/com/android/internal/policy/impl/PhoneWindowManager.java:        mEnableShiftMenuBugReports = "1".equals(SystemProperties.get("ro.debuggable"));
./frameworks/base/services/java/com/android/server/BootReceiver.java:        SystemProperties.getInt("ro.debuggable", 0) == 1 ? 98304 : 65536;
./frameworks/base/services/java/com/android/server/am/ActivityManagerService.java:    private static final String SYSTEM_DEBUGGABLE = "ro.debuggable";
./frameworks/base/services/java/com/android/server/wm/WindowManagerService.java:    private static final String SYSTEM_DEBUGGABLE = "ro.debuggable";
./frameworks/native/opengl/libs/EGL/egl.cpp:        property_get("ro.debuggable", value, "0");
./packages/services/Telephony/src/com/android/phone/AudioRouter.java:            (PhoneGlobals.DBG_LEVEL >= 1) && (SystemProperties.getInt("ro.debuggable", 0) == 1);
./packages/services/Telephony/src/com/android/phone/BluetoothManager.java:            (PhoneGlobals.DBG_LEVEL >= 1) && (SystemProperties.getInt("ro.debuggable", 0) == 1);
./packages/services/Telephony/src/com/android/phone/BluetoothPhoneService.java:            && (SystemProperties.getInt("ro.debuggable", 0) == 1);
./packages/services/Telephony/src/com/android/phone/CallCommandService.java:            (PhoneGlobals.DBG_LEVEL >= 1) && (SystemProperties.getInt("ro.debuggable", 0) == 1);
./packages/services/Telephony/src/com/android/phone/CallController.java:            (PhoneGlobals.DBG_LEVEL >= 1) && (SystemProperties.getInt("ro.debuggable", 0) == 1);
./packages/services/Telephony/src/com/android/phone/CallHandlerServiceProxy.java:            "ro.debuggable", 0) == 1);
./packages/services/Telephony/src/com/android/phone/CallLogger.java:        (SystemProperties.getInt("ro.debuggable", 0) == 1);
./packages/services/Telephony/src/com/android/phone/CallModeler.java:            (PhoneGlobals.DBG_LEVEL >= 1) && (SystemProperties.getInt("ro.debuggable", 0) == 1);
./packages/services/Telephony/src/com/android/phone/CallNotifier.java:            (PhoneGlobals.DBG_LEVEL >= 1) && (SystemProperties.getInt("ro.debuggable", 0) == 1);
./packages/services/Telephony/src/com/android/phone/CallStateMonitor.java:            (PhoneGlobals.DBG_LEVEL >= 1) && (SystemProperties.getInt("ro.debuggable", 0) == 1);
./packages/services/Telephony/src/com/android/phone/CallerInfoCache.java:            (PhoneGlobals.DBG_LEVEL >= 1) && (SystemProperties.getInt("ro.debuggable", 0) == 1);
./packages/services/Telephony/src/com/android/phone/CallerInfoCacheUpdateReceiver.java:            (PhoneGlobals.DBG_LEVEL >= 1) && (SystemProperties.getInt("ro.debuggable", 0) == 1);
./packages/services/Telephony/src/com/android/phone/CdmaDisplayInfo.java:    private static final boolean DBG = (SystemProperties.getInt("ro.debuggable", 0) == 1);
./packages/services/Telephony/src/com/android/phone/InCallScreenShowActivation.java:                    && (SystemProperties.getInt("ro.debuggable", 0) == 1)) {
./packages/services/Telephony/src/com/android/phone/InCallScreenShowActivation.java:            (PhoneGlobals.DBG_LEVEL >= 1) && (SystemProperties.getInt("ro.debuggable", 0) == 1);
./packages/services/Telephony/src/com/android/phone/NotificationMgr.java:            (PhoneGlobals.DBG_LEVEL >= 1) && (SystemProperties.getInt("ro.debuggable", 0) == 1);
./packages/services/Telephony/src/com/android/phone/OutgoingCallBroadcaster.java:            (PhoneGlobals.DBG_LEVEL >= 1) && (SystemProperties.getInt("ro.debuggable", 0) == 1);
./packages/services/Telephony/src/com/android/phone/PhoneGlobals.java:            (PhoneGlobals.DBG_LEVEL >= 1) && (SystemProperties.getInt("ro.debuggable", 0) == 1);
./packages/services/Telephony/src/com/android/phone/PhoneGlobals.java:     *   (PhoneApp.DBG_LEVEL >= 1) && (SystemProperties.getInt("ro.debuggable", 0) == 1)
./packages/services/Telephony/src/com/android/phone/PhoneGlobals.java:     *   1 - normal debug logging if ro.debuggable is set (which is true in
./packages/services/Telephony/src/com/android/phone/RespondViaSmsManager.java:            (PhoneGlobals.DBG_LEVEL >= 1) && (SystemProperties.getInt("ro.debuggable", 0) == 1);
./packages/services/Telephony/src/com/android/phone/Ringer.java:            (PhoneGlobals.DBG_LEVEL >= 1) && (SystemProperties.getInt("ro.debuggable", 0) == 1);
./packages/services/Telephony/src/com/android/phone/SipCallOptionHandler.java:            (PhoneGlobals.DBG_LEVEL >= 1) && (SystemProperties.getInt("ro.debuggable", 0) == 1);
./packages/services/Telephony/src/com/android/phone/WiredHeadsetManager.java:            (PhoneGlobals.DBG_LEVEL >= 1) && (SystemProperties.getInt("ro.debuggable", 0) == 1);
./sdk/eclipse/plugins/com.android.ide.eclipse.adt/src/com/android/ide/eclipse/adt/internal/launch/AndroidLaunchController.java:                        // because am -D does not check for ro.debuggable and the
./system/core/adb/adb.c:            property_get("ro.debuggable", value, "");
./system/core/adb/adb.c:    property_get("ro.debuggable", value, "");
./system/core/adb/services.c:        property_get("ro.debuggable", value, "");
./system/core/debuggerd/tombstone.c:    property_get("ro.debuggable", value, "0");
./system/core/include/cutils/trace.h: * level tracing is not allowed unless the ro.debuggable system property is
./system/core/init/property_service.c:    ret = property_get("ro.debuggable", debuggable);
./system/core/libcutils/trace.c:    property_get("ro.debuggable", value, "0");
./system/core/libcutils/trace.c:// application-level tracing is allowed when the ro.debuggable system property
./system/core/rootdir/init.rc:on property:ro.debuggable=1
```

#### 具体作用总结
* ./bootable/recovery/adb_install.cpp: debuggable 开启时,才可以成功重启adb
* ./build/xxxx : debuggable 数据设置
* ./dalvik/xxx : 在dalvik中,如果debuggable为0, 仅AndroidManifest.xml中含有debuggable 才会支持jdwp调试
* ./external/libnfc-nxp/Linux_x86/phDal4Nfc.c : NFC调试支持开关
* ./external/openssh/servconf.c: openssh 允许root访问开关
* ./frameworks/av/services/audioflinger/AudioFlinger.cpp: Audio Debug 开关
* ./frameworks/base/core/java/android/net/SSLCertificateSocketFactory.java: SSL check 开关
* ./frameworks/base/core/java/android/os/Build.java: IS_DEBUGGABLE环境变量控制
* ./frameworks/base/core/java/com/android/internal/os/ZygoteConnection.java: App debuggable 开关, 如果=1, 所有应用都将进行debug支持
* ./frameworks/base/policy/src/com/android/internal/policy/impl/PhoneWindowManager.java: mEnableShiftMenuBugReports 支持
* ./frameworks/base/services/java/com/android/server/BootReceiver.java: logged event size 控制, =1 存储量大
* ./frameworks/base/services/java/com/android/server/am/ActivityManagerService.java: 系统DEBUG状态
    * do Bug report
    * OpenGLTrace
    * App Profile
    * App Heap Dump
* ./frameworks/base/services/java/com/android/server/wm/WindowManagerService.java:  系统DEBUG状态
    * 与ro.secure 一起管理viewserver
* ./frameworks/native/opengl/libs/EGL/egl.cpp: EGL debug
*  LOGD 开关:
    * ./packages/services/Telephony/src/com/android/phone/AudioRouter.java:
    * ./packages/services/Telephony/src/com/android/phone/BluetoothManager.java: 
    * ./packages/services/Telephony/src/com/android/phone/BluetoothPhoneService.java
    * ./packages/services/Telephony/src/com/android/phone/CallCommandService.java
    * ./packages/services/Telephony/src/com/android/phone/CallController.java
    * ./packages/services/Telephony/src/com/android/phone/CallHandlerServiceProxy.java
    * ./packages/services/Telephony/src/com/android/phone/CallLogger.java
    * ./packages/services/Telephony/src/com/android/phone/CallModeler.java
    * ./packages/services/Telephony/src/com/android/phone/CallNotifier.java
    * ./packages/services/Telephony/src/com/android/phone/CallStateMonitor.java
    * ./packages/services/Telephony/src/com/android/phone/CallerInfoCache.java
    * ./packages/services/Telephony/src/com/android/phone/CallerInfoCacheUpdateReceiver.java
    * ./packages/services/Telephony/src/com/android/phone/CdmaDisplayInfo.java
    * ./packages/services/Telephony/src/com/android/phone/InCallScreenShowActivation.java
    * ./packages/services/Telephony/src/com/android/phone/InCallScreenShowActivation.java
    * ./packages/services/Telephony/src/com/android/phone/NotificationMgr.java
    * ./packages/services/Telephony/src/com/android/phone/OutgoingCallBroadcaster.java
    * ./packages/services/Telephony/src/com/android/phone/PhoneGlobals.java
    * ./packages/services/Telephony/src/com/android/phone/PhoneGlobals.java
    * ./packages/services/Telephony/src/com/android/phone/PhoneGlobals.java
    * ./packages/services/Telephony/src/com/android/phone/RespondViaSmsManager.java
    * ./packages/services/Telephony/src/com/android/phone/Ringer.java
    * ./packages/services/Telephony/src/com/android/phone/SipCallOptionHandler.java
    * ./packages/services/Telephony/src/com/android/phone/WiredHeadsetManager.java
* ./sdk/eclipse/plugins/com.android.ide.eclipse.adt/src/com/android/ide/eclipse/adt/internal/launch/AndroidLaunchController.java: ADT app debug launcher 支持
* ./system/core/adb/adb.c: adb root permission
* ./system/core/adb/services.c: adb root permission
* ./system/core/debuggerd/tombstone.c: dump_crash want log if =1
* ./system/core/init/property_service.c: Allow local property overwrite ro.debuggerd value
* ./system/core/libcutils/trace.c : app trace on/off
* ./system/core/rootdir/init.rc: adbd服务开启控制


### `ro.kernel.android.checkjni`
#### 源代码涉及的修改
```
./frameworks/base/core/jni/AndroidRuntime.cpp:        property_get("ro.kernel.android.checkjni", propBuf, "");
./dalvik/docs/embedded-vm-control.html:first is <code>ro.kernel.android.checkjni</code>.  This is set by the
./dalvik/docs/embedded-vm-control.html:of this overrides the value from <code>ro.kernel.android.checkjni</code>.
./build/core/main.mk:  ADDITIONAL_BUILD_PROPERTIES += ro.kernel.android.checkjni=1
./build/core/build-system.html:        <li><code>ro.kernel.android.checkjni=1</code>
```

#### 具体作用总结
* ./frameworks/base/core/jni/AndroidRuntime.cpp: checkJNI value load
* dalvik/xxx: Java VM CheckJNI on/off
* build/xxx: checkJNI 状态设置

### 总结
* ro.secure : 系统安全相关的属性控制开关
    * adb 的 ROOT 权限
    * viewserver(Hierarchy Viewer) 的开关
    * 系统各模块敏感信息dump的控制: http auth token
* ro.debuggable : 系统debug状态控制
    * 关键调试服务ADB的管理: 是否可root, 是否开机时运行
    * viewserver(Hierarchy Viewer) 的开关
    * 系统各模块debug信息开关:
        * 应用内部log控制dump
        * Audio Debug, SSL Check, NFC, OpenGL EGL 等level的dump, logged event size, atrace, mEnableShiftMenuBugReports
        * 系统级各 APP 级别状态: profile, jdwp-debug, heap dump, OpenGL Trace
* ro.kernel.android.checkjni
    * Java VM checkJNI on/off
