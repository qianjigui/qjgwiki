---
title: Java 编译处理过程
tags: JVM Compile
---

# 预编译过程

## 方案

* 现有方案: http://stackoverflow.com/questions/10483423/java-code-transform-at-compile-time
    * http://projectlombok.org/features/index.html
    * http://hllvm.group.iteye.com/group/topic/38188
* 利用Java 标注进行处理
    * http://deors.wordpress.com/2011/09/26/annotation-types/
* 将编译工具链进行连接整合, 一步步完成程序的生成
    * 利用GCC做预编译处理, 将C风格的宏进行处理, 将结果存储为JAVA
    * 再由javac完成后续编译
    * 存在的问题是: java就是在针对c的语言问题上, 提出了一些编译简化过程. 如果通过工具链整合, 又会引入坏味道

## 评估方法

* 工程化支持: 工具链, IDE的支持效果
