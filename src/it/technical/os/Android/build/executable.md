---
title: Android Native Executable 模块编译过程学习
tags: Make
tagline: 将Makefile打造成OOP
---

# 一个例子

1. Android.mk :

    ```
    LOCAL_PATH := $(call my-dir)
    include $(CLEAR_VARS)
    LOCAL_SRC_FILES := main.c
    LOCAL_MODULE := mm_test_execute
    iLOCAL_FORCE_STATIC_EXECUTABLE :=true
    include $(BUILD_EXECUTABLE)
    ```

2. 关键依赖模块

    ```
            Successfully remade target file `out/target/product/maguro/obj/EXECUTABLES/mm_test_execute_intermediates/import_includes'.
            Successfully remade target file `all_copied_headers'.
          Successfully remade target file `out/target/product/maguro/obj/EXECUTABLES/mm_test_execute_intermediates/main.o'.
        Successfully remade target file `out/target/product/maguro/obj/EXECUTABLES/mm_test_execute_intermediates/LINKED/mm_test_execute'.
      Successfully remade target file `out/target/product/maguro/symbols/system/bin/mm_test_execute'.
      Successfully remade target file `out/target/product/maguro/obj/EXECUTABLES/mm_test_execute_intermediates/export_includes'.
    Successfully remade target file `out/target/product/maguro/obj/EXECUTABLES/mm_test_execute_intermediates/mm_test_execute'.
      Successfully remade target file `NOTICE-TARGET-STATIC_LIBRARIES-libcompiler-rt-extras'.
    Successfully remade target file `out/target/product/maguro/system/bin/mm_test_execute'.
  Successfully remade target file `mm_test_execute'.
Successfully remade target file `all_modules'.
    ```

    1. import_includes
        1. 根据配置文件中描述的依赖的动态与静态库, 引入其模块产生的export_includes文件的内容.
        2. 以产生需要的头文件
    2. all_copied_headers
    3. x.o
    4. LINKED file
    5. Symbol file
    6. export_includes
        1. 产生export_includes 文件
    7. file
    8. install file


# 开发者需要关注的API

## 可以使用的工具

* [Android Profile](https://code.google.com/p/aprof/)
    * `LOCAL_ENABLE_APROF`
* 强制将依赖的动态库(目前仅用于/sbin/下的相关文件,libc库)合并为静态库
    * `LOCAL_FORCE_STATIC_EXECUTABLE :=true`
