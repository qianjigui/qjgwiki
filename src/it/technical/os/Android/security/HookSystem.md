---
title: Android系统hook各种组件方案
tags: XPosed
---

# 方法

整个Android系统是运行在一个类Java运行时环境上的, 我们通过劫持容器来完成对系统的控制.
这种劫持可以由不同工具达到不同的hook粒度, 例如下文分析的Xposed, 可以直接做到API 调用级别的hook.

# XPosed

## 来源

* 源代码: https://github.com/rovo89
* 官方门户: http://repo.xposed.info/

## 核心原理

整个Android环境的启动过程是:
1. bootloader
2. kernel
3. init service
4. `app_process service`
    1. zygote: 所有应用的母体容器
    2. `system_server`

XPosed 通过具有**root权限**(前提)的设备, 将系统原生的`app_process`进行替换, 来达到劫持整个容器的目的.

## 安装方法

注意最终的安装状态:

* Path: `/system/bin/app_process`
* filemode: `-rwxr-xr-x root     shell        9564 2015-08-28 15:32 app_process`
* filemode change: ` chown 0:2000 /system/bin/app_process && chmod 0755 /system/bin/app_process`

安装的主要途径:

* 系统root时
* recovery模式

## 实现细节

### 没有劫持虚拟机, 如何做到对于每个API的调用劫持

          在Android系统中, 应用程序进程都是由Zygote进程孵化出来的, 而Zygote进程是由Init进程启动的. Zygote进程在启动时会创建一个Dalvik虚拟机实例，每当它孵化一个新的应用程序进程时，都会将这个Dalvik虚拟机实例复制到新的应用程序进程里面去，从而使得每一个应用程序进程都有一个独立的Dalvik虚拟机实例。这也是Xposed选择替换app_process的原因。除此之外，Zygote进程在启动的过程中，还会将Java运行时库加载到进程中来，以及注册一些Android核心类的JNI方法到前面创建的Dalvik虚拟机实例中去。
          Xposed框架通过替换系统目录下/system/bin/app_process进程，进而控制zygote进程，最后使得app_process进程在启动的过程中，加载其框架的XposedBridge.jar包，令每个Android应用程序启动时，都加载XposedBridge.jar包。XposedBridge.jar具有一个私有的Native(JNI)方法hookMethodNative，它提供一个方法对象，利用java中的反射机制进行对内置方法的覆写，从而实现对Android系统API的hook。
          综上所述，Xposed框架实现hook的具体流程如下:
          1） Android系统启动，zygote进程加载XposedBridge.jar包；
          2） Xposed将所有需要替换的Method通过JNI方法hookMethodNative处理，将方法对象作为输入参数，并改变Dalvik虚拟机中对于该方法的定义，hookMethodNative会将该方法的类型变为native，同时，将此方法的实现链接到本地通用类的方法；
          3） hookMethodNative将被hook的Method指向Native方法xposedCallHandler，使得Method被调用时，其通用类的方法运行，不影响其调用者；
          4） xposedCallHandler转入handleHookedMethod，利用它传递Method相应的参数，控制方法执行流程，根据开发者输入的参数，在原方法执行之前或者之后运行替换的函数。

上述中的关键操作是: 
1. 利用JNI作为一个中转, 将所有对于被hook的方法统一进入xposed管理器, 管理器再进行hook的前后调用.
2. xposed 需要调用非JVM JNI标准接口, 需要准确调用 dalvik/art 中的方法调用, 完成对原函数的调用.

### 对于SeLinux的兼容与支持, 其中SeLinux主要做了什么

## 网上其它资料

* http://www.csdn.net/article/2015-08-14/2825462

## 参考学习

* Xprivacy
