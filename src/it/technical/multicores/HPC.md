---
title: "高性能计算"
tags: MultiCPU
---



#高性能计算#

##番外篇##
我的研究生毕业设计的方向是利用大规模计算平台做分布式高性能计算，这也是我的第一次接触大型机、第一次做科学计算类应用的开发。

##大视野##
做高性能计算，需要结合指定的业务领域、利用现有的计算资源做定向开发。
由于业务环境、硬件环境的要求，在做这方面的开发时需要考虑好框架和工具。

##工具##
目前主流的、用于并行计算的开源框架有：OpenMPI、OpenMP等相关联产品。
另外可以考虑选用线程模型来做局部的并行处理。

###多线程模型###
####入门阅读####
  * [手把手教你Linux下的多线程设计－－Linux下多线程编程详解(一) ](http://blog.csdn.net/frozen_fish/article/details/1679491)
  * [类成员函数作pthread_create的函数参数](http://hi.baidu.com/ivy_jing/blog/item/abe56f123ecab414213f2e1c.html)
  * [Linux多线程模型](http://hi.baidu.com/jiaju111/blog/item/f896ba2a1049e43f5343c180.html)
  * [Pthread互斥量与自旋锁的比较](http://www.searchtb.com/2011/01/pthreads-mutex-vs-pthread-spinlock.html)
  * [Pthread条件变量的调用关系](http://www.cnblogs.com/motadou/archive/2010/02/13/1668075.html)

感觉问题的关键是了解专用API，在毕业设计时苦于向Erlang的迁移而发现了Erlang自带的线程API，觉得还是值得尝试的。
  * Fork/Join模型
  * thread_create(...) 创建
  * thread_exit(...) 手动线程退出，返回相关结果
  * thread_join() 阻塞挂起，等待依赖线程退出
  * 利用互斥、信号量做调度
  * 在老API的基础上，参数是类成员函数建议使用static方法

####同步####
Futex原语

http://randu.org/tutorials/threads/

###OpenMP###
当我们正在自己组建具有一定通用效果的多线程模型时，已经有了专业的工具帮助我们做并行化处理。这就是[OpenMP](<%=(OpenMP)l%>).

###OpenMPI###
利用多线程进行分布式运算的推荐框架[OpenMPI](<%=(OpenMPI)l%>).

##总结与教训##

###Erlang的选用与问题###
当时选用Erlang做数值计算是比较主观的，
一方面刚好这个时候开始学习Erlang语言、并用其做了些小的应用程序，发现其的内建并行机制与消息传递特性非常方便，也想用到这个领域；
另一方面也是受到这篇 [讨论文献](http://www.google.com/url?sa=t&source=web&cd=1&ved=0CBcQFjAA&url=http%3A%2F%2Fwww.erlang.org%2Fworkshop%2F2008%2FSess23.pdf&rct=j&q=High-performance%20technical%20computing%20with%20erlang&ei=0j8bTpybIYPQhAecwIDNBQ&usg=AFQjCNFT9Fh4Lp0QHtWcdCnyHnS3PNpOXw&sig2=vLBrA-MRZxo_PIUrUNHGfg&cad=rja)的影响。

在真实使用中发现有如下问题:
  * 数值计算所依赖的数据*多*、初期接口数据结构设计不好，就容易导致函数参数过多过长。
  * 涉及大规模数据复制、传递、拷贝等问题时，由于Erlang的特性(做复制拷贝)，速度很慢。可以通过 *hipe_bifs* 库临时解决。
  * 通过C扩展完成计算逻辑，这个尝试成功了。但是业务逻辑、语言间交互接口及编码复杂、繁琐，得不偿失。
  * 如果在已经模块划分好的计算逻辑上做修改，由于Erlang的NIF、Driver、Port等接口的限制，很难只利用Erlang的消息传递、进程管理模块。

如果结合协议业务的编程思路，可以硬性规定数值计算数据摆放格式，通过强制类型转换等手法做到简化接口，整合NIF扩展的问题。不过改动复杂，一旦数据集发生变化都需要大范围更改。

其Driver PThread的实现多半是基于PThread的底层Library，在利用NIF做pthread构建时可以很好地连接C扩展与Erlang。

附:
  * [扯淡-erlang-的“适合”和“不适合”](http://www.mikespook.com/2010/02/扯淡-erlang-的“适合”和“不适合”/)

##环境##

###硬件###
这些计算环境一般都是由多个节点组成，节点内部可能有一个到多个CPU提供计算资源。
节点间通过虚拟化设备共享硬盘，通过专用线路相互连接。

在这其中，我们需要考虑多层不同的连接方式与主要瓶颈、节点的通信与交互、组成的基本体系结构。
譬如节点内CPU连接方式，节点间网络连接方式:
  1. [Intel CPU互联方案初探](http://www.360doc.com/content/10/1213/19/158286_77795484.shtml)

###软件###
主要是管理类软件。

####QSub####
[qsub命令介绍](http://www.clusterresources.com/torquedocs/commands/qsub.shtml)
