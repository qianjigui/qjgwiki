---
title: Android APP 模块编译过程学习
tags: Make APP
tagline: 将Makefile打造成OOP
---

# 一个例子
以下是进入一个已经编译完成的项目,
项目环境要求:
- PLATFORM_VERSION_CODENAME=REL
- PLATFORM_VERSION=4.2.2
- TARGET_PRODUCT=full_maguro
- TARGET_BUILD_VARIANT=userdebug
- TARGET_BUILD_TYPE=release
- TARGET_BUILD_APPS=
- TARGET_ARCH=arm
- TARGET_ARCH_VARIANT=armv7-a-neon
- HOST_ARCH=x86
- HOST_OS=linux
- HOST_OS_EXTRA=Linux-3.0.0-32-server-x86_64-with-Ubuntu-11.10-oneiric
- HOST_BUILD_TYPE=release
- BUILD_ID=JDQ39E
- OUT_DIR=out
其中,请注意需要使用userdebug版本,这样整个编译流程可以完全覆盖.

```shell
# Go to root
croot
# Go to Calculator which is a common module
cd packages/apps/Calculator
```

删除我们不关心的模块编译过程:

```diff
diff --git a/Android.mk b/Android.mk
index 90f5b5f..79b62a6 100644
--- a/Android.mk
+++ b/Android.mk
@@ -28,12 +28,3 @@ LOCAL_SDK_VERSION := current
 LOCAL_PACKAGE_NAME := Calculator
 
 include $(BUILD_PACKAGE)
-##################################################
-include $(CLEAR_VARS)
-
-LOCAL_PREBUILT_STATIC_JAVA_LIBRARIES := libarity:arity-2.1.2.jar
-
-include $(BUILD_MULTI_PREBUILT)
-
-# Use the folloing include to make our test apk.
-include $(call all-makefiles-under,$(LOCAL_PATH))
```

动态编译,获取中间结果:

```shell
mm -B --debug=b | tee basicdebug.log
grep target basicdebug.log | grep Successfully


      Successfully remade target file `out/target/common/obj/APPS/Calculator_intermediates/src/R.stamp'.
                  Successfully remade target file `out/target/common/obj/APPS/Calculator_intermediates/classes-full-debug.jar'.
                Successfully remade target file `out/target/common/obj/APPS/Calculator_intermediates/classes-jarjar.jar'.
              Successfully remade target file `out/target/common/obj/APPS/Calculator_intermediates/emma_out/lib/classes-jarjar.jar'.
            Successfully remade target file `out/target/common/obj/APPS/Calculator_intermediates/classes.jar'.
          Successfully remade target file `out/target/common/obj/APPS/Calculator_intermediates/proguard.classes.jar'.
        Successfully remade target file `out/target/common/obj/APPS/Calculator_intermediates/proguard.classes-with-local.dex'.
      Successfully remade target file `out/target/common/obj/APPS/Calculator_intermediates/proguard.classes.dex'.
    Successfully remade target file `out/target/product/maguro/obj/APPS/Calculator_intermediates/package.apk'.
      Successfully remade target file `out/target/product/maguro/obj/NOTICE_FILES/src//system/app/Calculator.apk.txt'.
    Successfully remade target file `out/target/product/maguro/system/app/Calculator.apk'.
  Successfully remade target file `Calculator'.
Successfully remade target file `all_modules'.
```
