---
title: Go 语言介绍 第一部分
tags: 
---

本文是对[introduction-to-go-golang-part-1](http://www.zhubert.com/blog/2014/01/12/introduction-to-go-golang-part-1/)的翻译

作者作为一个长期从事Web后端开发的工程师, 对Go语言有系统开发人员的具体认识.
Go语言的设计重点是: 解决软件工程中遇见的问题, 从工程上提升软件质量与开发效率

总体上说, Go语言有如下特点让作者称赞.

* 专注于解决开发效率问题:
    * 减少编译时间
    * 去掉显示关联, 降低模块间耦合
    * 利用静态语言特性, 提高性能
* 专注于解决现代编程中见到的问题:
    * 并行编程: CSP模型
    * 强大的基础库支持
* 简化语言内在复杂性
    * 语法关键字少: 只有25个
    * 添加了GC
    * 利用组合取代继承
    * 通过CSP模型简化目前常用的信号量锁等机制

# Go语言介绍 第一部分

If you read this blog for any amount of time you’ll know that I really like technology, specifically web development technologies. I’ve written about my experiences with Ruby on Rails, Batman, and a few curiosities along the way.

如果你经常阅读本网站的blog, 你会发现作者是一个技术爱好者, 特别是WEB开发技术.
作者在blog中谈论过自己在进行RoR, Batman等很多有意思的技术文章.

But my last post was something different, it was about Go. In a lot of ways it was the culmination of a journey, without trying to sound too weird, it was also the start of one.

但是作者最近的一些涉及Go语言的文章表现了一些风格的变化.
这是一段不同的技术旅程, 是一个看起来奇怪的开始.

Normally I don’t write about something until I feel like I have a decent grasp on it. So even though I started looking at Go over a year ago, I didn’t write anything about those experiences. At the beginning I was tempted to write about how Go was missing certain things…but that would’ve been premature. Now having used it for a bit longer, I understand it a lot better, though I still consider myself a novice and will likely be embarrassed about these posts in a few months (the perils of learning).

一般情况下, 作者在没有对一个事物有足够的认识前, 不会在文章中过多地讨论一些东西.
因此, 作者已经学习与了解go语言一年多了, 但并没有写文章对于这段开发经验进行讨论.
在开始的时候, 作者想讨论下Go语言在很多设计上的关键不足与问题, 但越发深入地使用后, 才发现原先的很多认识很片面.
在更加深入地学习与使用go语言后, 作者的理解更深刻, 也发现了以前对于Go语言的讨论存在问题.

So now that I’ve taken a few more steps, I’m ready to write about getting started, so that other people coming from a similar background could skip the confusion and go straight to the good stuff….enjoying Go for the awesome language that it is today. So let’s get started!

因此, 作者准备写一系列的文章对Go语言进行讨论, 从入手使用到深入运用的各个阶段.
通过文章描述, 希望可以让具有类似开发经验的人们, 可以避开一些go语言的理解困惑, 把握go语言的优点与方便. 
通过文章阅读, 可以充分体会这门语言的美丽与精妙.
让我们开始吧!

## Go的不同之处

Go is not what you think it is. It is not Java, It is not Ruby. It is not trying to be a language theorist’s dream. Go is not about type hierarchies. It is not about object-oriented programming or functional programming. Honestly, it has little to recommend it if you’re looking for something fashionable with all the buzzwords attached.

Go 语言并不是大家所想象的那样, 它不是Java不是Ruby.
它并不想成为编程语言研究者的梦想.
它不支持面对对象中的继承, 也不是一门面对对象/函数式语言.
老实说, GO语言并不是一门大家希望寻找的有趣又时髦的语言.

            Go’s purpose is therefore not to do research into programming language design; it is to improve the working environment for its designers and their coworkers. Go is more about software engineering than programming language research. Or to rephrase, it is about language design in the service of software engineering.
                Rob Pike Go at Google

        Go 语言并不是一门用于编程语言研究的语言, 而是一门便于开发与设计者用于改善现有工作环境中问题的编程语言.
        Go 语言的主要定位是软件工程而不是编程语言研究.
        换句话说, 就是Go语言是一门用于服务软件工程的语言.

                Rob Pike Go at Google


But Go is awesome, and you can get a lot done with it…you just have to learn it first. It’s tempting to approach new languages from the mindset of another language, but that will be most unhelpful here. It’s the easiest course to take…map a keyword from one language to the keyword of another, like a big Rosetta stone, but you will get frustrated pretty quickly. So before you do that, let’s look at where Go came from.

但是Go语言是可以用于做很多事情的一门很棒的语言.
你需要做的就是开始学习Go.
不过一般的开发者都会用以前其它语言的经验来臆断Go语言, 
就像一块很大的罗塞塔石碑, 简单地将其它语言的keyword放在Go上面.
这样的话, 学习都很容易产生困惑.
因此在你准备这样做之前, 请先整体了解下Go的设计理念.

## Go的起源

Being from a Physics background, I think it helps to start with first principles, so all the derivations make sense. Stated another way, Go was designed to solve a particular problem and the more we understand that, the more various design decisions will make sense.

每个东西的产生都有其原因和环境.
从这个角度看, Go语言的设计是用于解决一定范围的问题.
如果我们对这些问题了解的越多, 我们就越发能体会到其中设计的原因.

The creation myth of Go is something like this: Rob Pike, Ken Thompson, and Robert Griesemer were waiting for a particularly long C++ build to take place when they decided to theorize a new language. What started on a whiteboard in 2007, shortly thereafter turned into a specification, which then was open sourced in 2009 with two compiler implementations. The article Go at Google: Language Design in the Service of Software Engineering provides an excellent overview of these things.

Go语言的产生背景大致是这样的:
Rob Pike, Ken Thompson, 和 Robert Griesemer 在研究了C++语言的发展变化后, 他们决定构建一个新语言. 2007年, 他们将一些想法整理成了Go语言的主要特性, 在2009年, 他们对外开源了2个Go语言的编译器.

From this origin, we can discern a few problems that were explicitly set out to be solved by Go.

从这个原因, 我们将看到Go语言准备解决的具体问题.

## 问题一: 开发效率问题

The bane of compiled languages and the siren’s song of intepreted languages, slow builds are enough to drive anyone crazy. Once the build is slow enough, developer productivity goes out the window, as even simple changes can take forever to materialize. But optimizing for developer happiness (in the form of a fast dev cycle) generally has meant slow performance for the million or billion times that the code gets run in production. It’s a painful tradeoff.

如同毒一样的编译型语言与如同海妖之歌的解释型语言, 在编译构建阶段, 都是可以慢地让人发疯.
在编译很慢的时候, 开发人员可以到窗外转一圈, 一些简单地修改都需要大量的编译时间.
如果简单地对编译时间进行优化, 又会导致程序在使用过程中性能下降.
编译速度与运行速度是需要做一个平衡的.

Go enters the picture as a great compromise in this regard. The compiled code is super fast (see previous post) and the build times are negligible. Massive projects still have subsecond build times. How does it do it?

Go语言就是准备解决这个问题. 一方面, 其产生的程序运行速度很快, 另一方面, 其占用的编译时间是很少的.
很大的项目在编译上的花费也就是几秒.
这是如何做到的?

Well, let’s take the often complained about decision to have unused imports throw compile errors. This is intrinsic with this desire to go fast! The experience of the language designers on huge projects taught them that unnecessary includes resulted in ridiculous extraneous I/O during builds while imports would be included thousands of extra times. Throwing the error then is a friendly reminder from the compiler to take that trash out of your code so you can go fast.

目前大家讨论与抱怨比较多的是, Go语言在发现不必要的import时会提示错误.
这是在编译期速度快的一个原因.
一些有经验的开发者发现在很多大型项目中, 如果一个程序源代码大量无效引用了外部文件,
会导致编译期大量的IO操作, 这样就导致了编译期大量的时间浪费.
目前这种设计: 在发现无效import时报错, 对于开发者是很好的帮助, 另一方面又可以优化编译时间.

        The construction of a single C++ binary at Google can open and read hundreds of individual header files tens of thousands of times. In 2007, build engineers at Google instrumented the compilation of a major Google binary. The file contained about two thousand files that, if simply concatenated together, totaled 4.2 megabytes. By the time the #includes had been expanded, over 8 gigabytes were being delivered to the input of the compiler, a blow-up of 2000 bytes for every C++ source byte.
        Rob Pike Go at Google

        在google, 一个独立的C++二进制程序在构建过程中一般会引用读取数万个独立的头文件.
        在2007年, Google的构建工程师统计发现, 一般一个二进制程序会包含近两千文件, 如果简单的合并起来, 总共有4.2M. 如果将所有的include文件全部展开,有将近8G的文件将进入编译器.
        平均源代码的每byte就有近2000bytes的占用.

            Rob Pike Go at Google

This is also connected to the decision to not declare implements explicitly for interfaces. If you have to type implements in all the spots that an interface is satisfied, that also means you have to include the “header” of the place where that interface is defined…once again, many more includes which would slow down the builds. Implicit satisfication of interfaces also results in more flexible code, which is itself more resilient to change, delaying interface ossification as long as possible (which is a good thing!).

另一方面, 为了减少引用, 每个结构没有必要显式声明其实现的具体接口.
如果按java的方式, 每个接口都显式地声明其需要实现的接口, 一方面增加了代码模块间的依赖关系;
另一方面, 这种显式的引用导致了大量的编译时间浪费.
如果接口发生变化, 会要求各实现模块完整实现各模块.


If you didn’t know the above, you might be tempted to complain, “why do I have to add and delete the fmt package for debugging, how annoying!”, when in fact the language is preventing you from slowing down your builds. It isn’t intuitive, since we’ve become used to these very language “features” which ultimately undermine larger projects.

如果开发者不了解上面这些设计原则, 就会抱怨"为何需要将用于调试的fmt模块进行删除, 太麻烦了",
而实际是为了帮助开发者提升编译效率.
这种特性也非常有助于大型项目的开发.

As this is the Internet, I feel compelled to throw in the YMMV caveat. If you know the gotchas of whatever language you’ve been using for years, you’ll be able to avoid many things simply due to your skill. I think Go helps the average developer not make these sort of mistakes (because they are compile errors). An important distiction to keep in mind, and one coherent with the language designers’ goals.

在互联网时代, .
如果你以前使用的很多语言, 你将在开发中发现很多问题.
我认为Go语言的这个特性帮助程序员忽略很多错误.
这也是Go语言的设计目标与初衷.

## 问题二: 现代化

        The computing landscape today is almost unrelated to the environment in which the languages being used, mostly C++, Java, and Python, had been created. The problems introduced by multicore processors, networked systems, massive computation clusters, and the web programming model were being worked around rather than addressed head-on.

        Rob Pike Go at Google

        在现代编程环境中, 已经有大量的现代编程语言出现与使用, 例如 C++, Java, Python, 但目前的问题已经不再是编程语言的选择上了.
        目前的问题已经成为: 多核心, 网络系统, 大计算集群 与 Web开发编程模型, 而不再是原先的基于地址的简单编程.

        Rob Pike Go at Google

C++ 1979. Python 1989. Java 1990. Ruby 1993. Let’s face it…that’s more than a few internet years. As a computer guy, I’m confident we could do our jobs with any sane language (having worked in Fortran77 for a short while, I can attest that you can build stuff with almost any tool), but the question of suitability of a language for a particular task should be considered.

在过去的一些年, 有大量的编程语言产生, 这些数量的语言如果互联网络时代一样, 繁花似锦. 1979 C++, 1989 Python, 1990 Java, 1993 Ruby.
作为一个程序员, 其它用什么语言完成任务都是可以的.
不过从合适度上, 目前的问题已经成为找到一门合理的语言快速有效地完成工作.

How does that play out? For Go, I’d reference the concurrency model and it’s standard library. I want to write more about these in depth, so a brief aside will have to suffice here.

Go语言的现代特性主要是并行化支持与强大的标准库.
作者已经在这方面写了很多文章, 这里仅简单地介绍下.

### 并行

Let’s say you want to decompose a linear process into a concurrent one…one which can be parallelized if the running environment were to permit it. In Go, it’s this easy:

我们目前来简单演示下如何将一个线性处理过程转成并行.

<script src="https://gist.github.com/qianjigui/7f60d0b16dbe3b7445e0.js"></script>

Now, there a many approaches to concurrency but they can be notoriously difficult to reason about. If you have had to debug a deadlock with mutexes, you don’t need me to elaborate on this. Go’s approach results in code that is easily understood as it can be reasoned about like a sequential program. That’s a huge plus.

现在, 目前已经有很多并行编程的方法, 但是都很难编写与设计.
如果你正在调试一个信号量的死锁问题, 你目前已经没有很好的调试方法.
Go语言在这方面的设计就更容易让开发者理解, 你可以像串行编程一样进行开发.
这可以说是Go语言的强大扩展.

If this is your first foray into CSP, I recommend reading the original CSP paper by Hoare. It’s epic. If a video is more your thing, try Rob Pike’s talk: Concurrency is not Parallelism.

如果这是你第一次接触CSP, 我建议你认真了解下由Hoare编写的CSP的相关文章.
如果有兴趣可以详细看到这个视频.

### 强大的标准库

The Go developers like to describe the standard library as a “batteries-included” library. What I think they mean by that is if you spin up a simple webserver like so:

Go语言开发者需要将标准库看到一组增量工具库.
作者认为他们可能是觉得实现一个功能可以很简单地搭建展开.
例如如下的这个web服务:

<script src="https://gist.github.com/qianjigui/1a91e6e5e1ed39dafffb.js"></script> 

that it will actually be awesome from the start (I’d say “webscale” but then I couldn’t finish writing the article for humilitation). This leads to one source of confusion for newbies who immediately ask for the “Ruby on Rails” of Go. There are plenty of great libraries that build upon the strong foundations of the Standard Library, but you can get away without having to use them. I admit, it was really weird for me at first that I could use a standard library and not a diadem-full of Gems to build something.

这就导致了一些开发者会有为何没有如同RoR的开发库.
其实在Go语言中, 有很多基于Go语言富强大的基础设施标准库上面的的框架库, 但是你可以在不需要这些扩展库的情况下通过基础设施简单地构建出来.
作者说, 在使用Go语言进行开发时, 通过简单库构建功能业务是件让人很开心的事情.

Ok, well I want to cover those again in the future, so for now, that will have to suffice.

好了, 先讨论到这里, 关于Go语言的现代性, 作者会在后续的文章中详细谈到.

## 问题三: 复杂性

Finally, I think the Go designers wanted to keep the language simple (simple in the usual definition of simple).

最后呢, 作者认为Go语言的设计者希望将语言设计的简单(在语言定义与使用上简单).

* How many loop keywords are there? 1 for
* Why Garbage Collection? Because it’s easier while working with concurrency.
* Why eliminate inheritance? Because it’s inflexible to change and composition is almost always better.
* How many keywords? 25. vs 50 in Java and 48 in C++ Expressiveness of Go
* Why CSP model for concurrency? Because mutexes and locking are a hard paradigm to get right.

* 只有1种描述循环的关键字: for
* 有GC特性, 便于并行编程的数据生命周期控制
* 为何去掉**继承**? 因为对扩展性不好, 取而代之的是**组合**
* 仅有25个关键字: java中是50, C++是48
* 为何选用CSP模型用于并行开发? 因为信号量与锁非常难管理

Another way to see this is you can sit down and read the Language Specification in one sitting and have it all in your working memory. The concepts are “simple” enough that this is a feasible task. It’s actually really cool…one, that there is a language spec…nudge nudge…but primarily that it’s written in such comprehensible terms. I’ve had serveral sittings by the fire with the spec in one hand and a Lagavulin 16 in the other…and each time I appreciate the efforts of the developers in documenting their work.

如果想更详细地了解Go语言, 你可以阅读Go语言规格.
"简明"这个概念在Go语言中到处体现.

If you’ve read this far, then you are most certainly a delightful person. I’ll write quite a bit more on Go, hopefully this was a helpful first step.


