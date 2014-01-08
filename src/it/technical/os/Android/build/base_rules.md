---
title: Android baes_rules 模块编译过程学习
tags: Make
tagline: 将Makefile打造成OOP
---

# 编译脚本分析

- build/core/base_rules.mk
    - Variables Check
    - .aidl to .java
    - .logtags
    - .proto to .java
    - .java to .class

# 主要功能

由于涉及到大量基本的处理, 主要是定义了公共的依赖关系定义.
