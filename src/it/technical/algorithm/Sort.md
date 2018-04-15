---
title: "排序"
tags: DataStructure
---

今天交流技术问题,在线进行了一个编程练习. 主要是讨论排序问题的.
目前在业界的实践,基本是直接使用语言库中的排序方法.
那在各个语言库中, 主要都使用了什么排序呢?

### 主流编程语言中的排序算法

java中
c标准库中
python/ruby中

#### golang

_go version go1.10.1 darwin/amd64_

* 非稳定排序: `sort.Sort`: 是一个以快速排序为主要方案的混合排序方案, 具体见论文[Engineering a Sort Function](http://cs.fit.edu/~pkc/classes/writing/samples/bentley93engineering.pdf)
* 稳定排序: 


看着很高深的一个方案: 桶排序https://blog.csdn.net/ii1245712564/article/details/45869623

目前主流语言的hash表
