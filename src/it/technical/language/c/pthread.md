---
title: "Linux 线程编程"
---

共享整个进程空间：内存、文件句柄等。

主要概念:

* 标识
* 创建
* 终止
* 同步

多线程解决的主要问题：

1. 计算资源的充分利用
2. 资源共享与互斥
3. 僵尸线程: 线程自然退出后，其线程仍然有一块内存区域用于保存这个线程的上下文context 没有被 销毁

具体应用领域: OpenMP
