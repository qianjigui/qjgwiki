---
title: Android STATIC_JAVA_LIBRARY 模块编译过程学习
tags: Make
tagline: 将Makefile打造成OOP
---

# 编译脚本分析

- build/core/static_java_library.mk
    - 环境设置
        - LOCAL_UNINSTALLABLE_MODULE := true
        - LOCAL_IS_STATIC_JAVA_LIBRARY := true
        - package resouces
    - build/core/java_library.mk
    - 处理R.stamp

# 整体分析

从上述模块结构, 我们可以看到, static_java_library 作为一个静态库
需要对资源进行支持.
