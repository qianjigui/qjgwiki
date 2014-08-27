---
title: Android系统内存优化学习
tags: Memory
---

# 学习过程中涉及的问题点

1. 内存泄漏的核心问题: 长生命周期(存活)object引用了短生命周期object
    1. Android系统Google开发环境提供的编程环境是Context+Logic的开发模式, 在这种模式下程序员容易将一些生命周期不一致的object进行关联,导致内在泄漏
    2. 需要注意Java语言级别的生命周期与框架的对应与关系
