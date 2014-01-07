---
title: Android JAVA_LIBRARY 模块编译过程学习
tags: Make
tagline: 将Makefile打造成OOP
---

# 一个例子

利用development/samples/UiAutomator模块进行学习

## 中间产生的所有模块

```shell
                    out/target/common/obj/JAVA_LIBRARIES/uiautomator.samples_intermediates/classes-full-debug.jar
                  out/target/common/obj/JAVA_LIBRARIES/uiautomator.samples_intermediates/classes-jarjar.jar
                out/target/common/obj/JAVA_LIBRARIES/uiautomator.samples_intermediates/emma_out/lib/classes-jarjar.jar
              out/target/common/obj/JAVA_LIBRARIES/uiautomator.samples_intermediates/classes.jar
            out/target/common/obj/JAVA_LIBRARIES/uiautomator.samples_intermediates/noproguard.classes.jar
          out/target/common/obj/JAVA_LIBRARIES/uiautomator.samples_intermediates/noproguard.classes-with-local.dex
        out/target/common/obj/JAVA_LIBRARIES/uiautomator.samples_intermediates/noproguard.classes.dex
      out/target/common/obj/JAVA_LIBRARIES/uiautomator.samples_intermediates/javalib.jar
    out/target/product/maguro/obj/JAVA_LIBRARIES/uiautomator.samples_intermediates/javalib.jar
    out/target/product/maguro/system/framework/uiautomator.samples.jar
  uiautomator.samples
all_modules
```

从上面的log看,其主要的过程与[APP](<%=(APP)l%>)相同.
主要区别是最后产生的是javalib.jar, 需要进行安装的是/system/framework/uiautomator.samples.jar

具体模块列表如下:

- 没有R.stamp
- out/target/common/obj/JAVA_LIBRARIES/uiautomator.samples_intermediates/classes-full-debug.jar
- out/target/common/obj/JAVA_LIBRARIES/uiautomator.samples_intermediates/classes-jarjar.jar
- out/target/common/obj/JAVA_LIBRARIES/uiautomator.samples_intermediates/emma_out/lib/classes-jarjar.jar
- out/target/common/obj/JAVA_LIBRARIES/uiautomator.samples_intermediates/classes.jar
- 以下是没有进行proguard处理的中间模块
- out/target/common/obj/JAVA_LIBRARIES/uiautomator.samples_intermediates/noproguard.classes.jar
- out/target/common/obj/JAVA_LIBRARIES/uiautomator.samples_intermediates/noproguard.classes-with-local.dex
- out/target/common/obj/JAVA_LIBRARIES/uiautomator.samples_intermediates/noproguard.classes.dex
- 以下有不同, 多出来了一个处于common的javalib.jar打包文件
- out/target/common/obj/JAVA_LIBRARIES/uiautomator.samples_intermediates/javalib.jar
- out/target/product/maguro/obj/JAVA_LIBRARIES/uiautomator.samples_intermediates/javalib.jar
- out/target/product/maguro/system/framework/uiautomator.samples.jar
- uiautomator.samples
- all_modules

## 过程分析

### 没有R.stamp

这个东西,现在看看, 应该算是一个不通用的设计.
从而导致了Android自身的资源也是单独放在一个APK中进行framework化的.
像Android的framework-res.apk作为公共资源, 也不得不利用LOCAL_EXPORT_PACKAGE_RESOURCES这样的接口完成工作.

可见目前的framework 是不支持资源的.

### java.mk相关的处理
- out/target/common/obj/JAVA_LIBRARIES/uiautomator.samples_intermediates/classes-full-debug.jar
- out/target/common/obj/JAVA_LIBRARIES/uiautomator.samples_intermediates/classes-jarjar.jar
- out/target/common/obj/JAVA_LIBRARIES/uiautomator.samples_intermediates/emma_out/lib/classes-jarjar.jar
- out/target/common/obj/JAVA_LIBRARIES/uiautomator.samples_intermediates/classes.jar

现在看看,主要是java->classes->jarjar->emma->proguard

### out/target/common/obj/JAVA_LIBRARIES/uiautomator.samples_intermediates/javalib.jar

主要是为了统一JAVA\_LIBRARY 与 STATIC_JAVA_LIBRARY.

### out/target/product/maguro/obj/JAVA_LIBRARIES/uiautomator.samples_intermediates/javalib.jar

产生需要安装的模块.

该部分与APP不同, 没有如下过程:

1. signature zip
2. Alignment zip

# 编译脚本

整体过程与APP类似, 仅从main.mk出来后进入的是java_library.mk

## Makefile 处理过程
- Makefile
    - build/core/main.mk
        - studymodules/UiAutomator/Android.mk
            - build/core/clear_vars.mk
            - build/core/java_library.mk
                - build/core/java.mk
                    - build/core/base_rules.mk

## 具体过程

上下文与APP类似,主要关注java_library.mk

- build/core/java_library.mk
    - 环境设置
        - LOCAL_MODULE_SUFFIX
        - LOCAL_MODULE_CLASS
        - LOCAL_BUILT_MODULE_STEM := javalib.jar
        - dexpreopt
        - emma
    - build/core/java.mk
    - Check is STATIC Library
        - Static
            - Copy classes.jar to built
        - Shared
            - classes to dex
            - dex to jar
            - dexpreopt

# 编译相关API
## 可以使用的工具

在这方面, 整个工具体系主要是java相关的.

没有了签名,align过程.

## Java主要API

### SRC
1. java
2. RenderScript
3. Proto
4. AIDL
5. jni

上述过程已经变得简化, 目前涉及java的模块仅有一个static.
全部分析完后, 我们可以从前后关联上看看是如何实现依赖与继承的.
