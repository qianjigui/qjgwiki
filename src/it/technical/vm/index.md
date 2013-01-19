---
title: "虚拟机技术相关概要"
tags: VM
---

#虚拟机(Virtual Machines)#

##介绍(Introduction)##

###计算机体系结构(Computer Architecture)###

##语言虚拟机##
目前有大量的语言虚拟机出现，对具体使用环境的支持越发成熟。

### Internal Structure ###
* Class model
* Class loader
* Threads Sync
* Objects 保护机制

### Heap ###
* GC

### Native Interface ###
* JNI

### Interp ###
* Stack-mode
* Register-mode
* AOT
* JIT

### Tools ###
* Heap: MAT, JHAT, Hprof, information
* Debugger

### Examples ###
* Facebook已将HHVM/JIT用于其开发和产品中
    1. HHVM这样运行PHP程序，先将PHP源代码转换为HipHop字节码（HHBC），然后使用字节码解释器和x64 JIT编译器来执行字节码。
    1. 这里的解释器和编译器可以无缝地进行互操作。
    1. HHVM会尽可能使用JIT，万不得已时才将解释器作为执行引擎。
