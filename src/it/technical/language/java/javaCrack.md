---
title: Java Crack 技术
tags: Crack
---

# 主要工具与方法

* JAD

# 防护

## [proguard](http://proguard.sourceforge.net/)

该工具可以针对java class文件做如下处理:

* 压缩
    * 检测推算并删除: 无用的类, 字段, 方法, 属性与修饰
* 优化
    * 用于优化字节码, 删除无用指令
* 混淆
    * 将类, 方法, 字段进行重命名
* 预校验
    * 保证编译完成的字节码可用于Java6及以上版本

# 二进制程序结构

程序的整个反编译过程由二进制程序出发, 通过二进制程序中的数据来进行程序的还原.

http://docs.oracle.com/javase/specs/jvms/se7/html/jvms-4.html

