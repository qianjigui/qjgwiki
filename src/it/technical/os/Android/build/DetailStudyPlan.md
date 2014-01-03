---
title: Android 编译系统学习计划
tags: Make
tagline: 将Makefile打造成OOP
---

# 整体目标
- 将原先的功能学习通过demo串起来
- 系统化整个demo运行过程中的问题

# 相关问题
1. APP 编译完整流程
    1. 中间产生物
    2. 内置工具优化与整合: proguard, lint, signature
    3. 对外提供的API
2. 编译系统的整个工作过程
3. PREBUILT dexpreopt
4. apk去so化
5. Hack编译系统,添加与修改相关变量
6. 面向对象化的编译系统模块设计

# 一般学习方法与策略
1. 代码静态学习
2. 通过编译系统动态调试学习
    1. 准备一个完整的Opensource编译环境
    2. 整体编译完成
    3. 通过单个模块进行分析:

        ```shell
        # Add -d to make for debugging information
        mm -B -d | tee a.log
        ```

    4. 查看a.log

