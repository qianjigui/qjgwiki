---
title: "Programming Eralng"
tags: Erlang
---


#整体介绍#
* Paperback: 536 pages
* Publisher: Pragmatic Bookshelf; 1 edition (11 July 2007)
* Language English

##网络上总结的读书笔记##
http://www.javaeye.com/wiki/erlang?category_id=91

##内容简介##

《Erlang程序设计》是讲述下一代编程语言Erlang 的权威著作，主要涵盖顺序型编程、异常处理、编译和运行代码、并发编程、并发编程中的错误处理、分布式编程、多核编程等内容。《Erlang程序设计》将 帮助读者在消息传递的基础上构建分布式的并发系统，免去锁与互斥技术的羁绊，使程序在多核CPU 上高效运行。《Erlang程序设计》讲述的各种设计方法和行为将成为设计容错与分布式系统中的利器。

##编辑推荐##
《Erlang程序设计》由Erlang之父Joe Armstrong编写，是毋庸置疑的经典著作。书中兼顾了顺序编程、并发编程和分布式编程，较深入地讨论了开发Erlang应用中至关重要的文件和网络 编程、OTP、MNesia、Ets和Dets等主题，更为精彩的是，大师亲自操刀，构建了MapReduce实例和多人聊天实例，一定让你大呼过瘾。

在多核、并发、分布为王的时代，谁将成为下一个主流编程语言？来自全世界的众多专家都认为，Erlang最有可能在竞争中胜出。

Erlang 开源语言系出名门，通信巨头爱立信公司用它开发出了可靠性惊人的交换机系统AXD301。它天生就是面向并发、分布和高容错的，兼有函数式语言和脚本语言 的各种优点，而且已经用于商业开发多年，具有稳定性极高的虚拟机和平台库。有了这些天时地利，无怪乎Erlang能够迅速成为热门的开发语言，除了广泛应 用于通信行业之外，它已经进入了各个领域：Facebook用它实现了聊天系统，Yahoo用它重写了Delicious，Amazon用它开发了云计算 数据服务SimpleDB，还有多人游戏、测试工具、电子支付、数据采集与监控、企业消息、电子邮件、空中交通管制。


##目录##
第1章　引言　1
1.1　路线图　1
1.2　正式起航　3
1.3　致谢　3

第2章　入门　5
2.1　概览　5
2.1.1　阶段1：茫然无绪　5
2.1.2　阶段2：初窥门径　5
2.1.3　阶段2.5：观其大略，不求甚解　6
2.1.4　阶段3：运用自如　6
2.1.5　重中之重　6
2.2　Erlang安装　7
2.2.1　二进制发布版　7
2.2.2　从源代码创建Erlang　8
2.2.3　使用CEAN　8
2.3　本书代码　8
2.4　启动shell　9
2.5　简单的整数运算　10
2.6　变量　11
2.6.1　变量不变　12
2.6.2　模式匹配　13
2.6.3　单一赋值为何有益于编写质量更高的代码　14
2.7　浮点数　15
2.8　原子　16
2.9　元组　17
2.9.1　创建元组　18
2.9.2　从元组中提取字段值　18
2.10　列表　19
2.10.1　术语　20
2.10.2　定义列表　20
2.10.3　从列表中提取元素　20
2.11　字符串　21
2.12　再论模式匹配　22

第3章　顺序型编程　24
3.1　模块　24
3.2　购物系统——进阶篇　28
3.3　同名不同目的函数　31
3.4　fun　31
3.4.1　以fun为参数的函数　32
3.4.2　返回fun的函数　33
3.4.3　定义你自己的抽象流程控制　34
3.5　简单的列表处理　35
3.6　列表解析　38
3.6.1　快速排序　39
3.6.2　毕达哥拉斯三元组　40
3.6.3　变位词　40
3.7　算术表达式　41
3.8　断言　41
3.8.1　断言序列　42
3.8.2　断言样例　43
3.8.3　true断言的使用　44
3.8.4　过时的断言函数　44
3.9　记录　44
3.9.1　创建和更新记录　45
3.9.2　从记录中提取字段值　45
3.9.3　在函数中对记录进行模式匹配　46
3.9.4　记录只是元组的伪装　46
3.10　case/if表达式　46
3.10.1　case表达式　47
3.10.2　if表达式　47
3.11　以自然顺序创建列表　48
3.12　累加器　48

第4章　异常　50
4.1　异常　50
4.2　抛出异常　51
4.3　try...catch　51
4.3.1　缩减版本　53
4.3.2　使用try...catch的编程惯例　53
4.4　catch　54
4.5　改进错误信息　55
4.6　try...catch的编程风格　55
4.6.1　经常会返回错误的程序　55
4.6.2　出错几率比较小的程序　56
4.7　捕获所有可能的异常　56
4.8　新老两种异常处理风格　56
4.9　栈跟踪　57

第5章　顺序型编程进阶　58
5.1　BIF　58
5.2　二进制数据　58
5.3　比特语法　60
5.3.1　16bit色彩的封包与解包　60
5.3.2　比特语法表达式　61
5.3.3　高级比特语法样例　62
5.4　小问题集锦　67
5.4.1　apply　68
5.4.2　属性　68
5.4.3　块表达式　71
5.4.4　布尔类型　71
5.4.5　布尔表达式　72
5.4.6　字符集　72
5.4.7　注释　72
5.4.8　epp　73
5.4.9　转义符　73
5.4.10　表达式和表达式序列　74
5.4.11　函数引用　74
5.4.12　包含文件　75
5.4.13　列表操作符++和——　75
5.4.14　宏　76
5.4.15　在模式中使用匹配操作符　77
5.4.16　数值类型　78
5.4.17　操作符优先级　79
5.4.18　进程字典　79
5.4.19　引用　80
5.4.20　短路布尔表达式　80
5.4.21　比较表达式　81
5.4.22　下划线变量　82

第6章　编译并运行程序　83
6.1　开启和停止Erlang shell　83
6.2　配置开发环境　84
6.2.1　为文件加载器设定搜索路径　84
6.2.2　在系统启动时批量执行命令　85
6.3　运行程序的几种不同方法　86
6.3.1　在Erlang shell中编译运行　86
6.3.2　在命令提示符下编译运行　86
6.3.3　把程序当作escript脚本运行　88
6.3.4　用命令行参数编程　89
6.4　使用makefile进行自动编译　90
6.4.1　makefile模板　90
6.4.2　定制makefile模板　92
6.5　在Erlang shell中的命令编辑　93
6.6　解决系统死锁　93
6.7　如何应对故障　93
6.7.1　未定义/遗失代码　94
6.7.2　makefile不能工作　94
6.7.3　shell没有响应　95
6.8　获取帮助　96
6.9　调试环境　96
6.10　崩溃转储　97

第7章　并发　98

第8章　并发编程　101
8.1　并发原语　101
8.2　一个简单的例子　102
8.3　客户/服务器介绍　103
8.4　创建一个进程需要花费多少时间　107
8.5　带超时的receive　109
8.5.1　只有超时的receive　109
8.5.2　超时时间为0的receive　109
8.5.3　使用一个无限等待超时进行接收　110
8.5.4　实现一个计时器　110
8.6　选择性接收　111
8.7　注册进程　112
8.8　如何编写一个并发程序　113
8.9　尾递归技术　114
8.10　使用MFA启动进程　115
8.11　习题　115

第9章　并发编程中的错误处理　116
9.1　链接进程　116
9.2　on_exit处理程序　117
9.3　远程错误处理　118
9.4　错误处理的细节　118
9.4.1　捕获退出的编程模式　119
9.4.2　捕获退出信号(进阶篇)　120
9.5　错误处理原语　125
9.6　链接进程集　126
9.7　监视器　126
9.8　存活进程　127

第10章　分布式编程　128
10.1　名字服务　129
10.1.1　第一步：一个简单的名字服务　130
10.1.2　第二步：在同一台机器上，客户端运行于一个节点而服务器运行于第二个节点　131
10.1.3　第三步：让客户机和服务器运行于同一个局域网内的不同机器上　132
10.1.4　第四步：在因特网上的不同主机上分别运行客户机和服务器　133
10.2　分布式原语　134
10.3　分布式编程中使用的库　136
10.4　有cookie保护的系统　136
10.5　基于套接字的分布式模式　137
10.5.1　lib_chan　137
10.5.2　服务器代码　138

第11章　IRC Lite　141
11.1　消息序列图　142
11.2　用户界面　143
11.3　客户端程序　144
11.4　服务器端组件　147
11.4.1　聊天控制器　147
11.4.2　聊天服务器　148
11.4.3　群组管理器　149
11.5　运行程序　150
11.6　聊天程序源代码　151
11.6.1　聊天客户端　151
11.6.2　Lib_chan配置　154
11.6.3　聊天控制器　154
11.6.4　聊天服务器　155
11.6.5　聊天群组　156
11.6.6　输入输出窗口　157
11.7　习题　159

第12章　接口技术　160
12.1　端口　161
12.2　为一个外部C程序添加接口　161
12.2.1　C程序　162
12.2.2　Erlang程序　164
12.3　open_port　167
12.4　内联驱动　167
12.5　注意　170

第13章　对文件编程　172
13.1　库的组织结构　172
13.2　读取文件的不同方法　172
13.2.1　从文件中读取所有Erlang数据项　174
13.2.2　从文件的数据项中一次读取一项　174
13.2.3　从文件中一次读取一行数据　176
13.2.4　将整个文件的内容读入到一个二进制数据中　176
13.2.5　随机读取一个文件　176
13.2.6　读取ID3标记　177
13.3　写入文件的不同方法　179
13.3.1　向一个文件中写入一串Erlang数据项　179
13.3.2　向文件中写入一行　181
13.3.3　一步操作写入整个文件　181
13.3.4　在随机访问模式下写入文件　183
13.4　目录操作　183
13.5　查询文件的属性　184
13.6　复制和删除文件　185
13.7　小知识　185
13.8　一个搜索小程序　186

第14章　套接字编程　189
14.1　使用TCP　189
14.1.1　从服务器上获取数据　189
14.1.2　一个简单的TCP服务器　192
14.1.3　改进服务器　195
14.1.4　注意　196
14.2　控制逻辑　197
14.2.1　主动型消息接收(非阻塞)　197
14.2.2　被动型消息接收(阻塞)　198
14.2.3　混合型模式(半阻塞)　198
14.3　连接从何而来　199
14.4　套接字的出错处理　199
14.5　UDP　200
14.5.1　最简单的UDP服务器和客户机　201
14.5.2　一个计算阶乘UDP的服务器　201
14.5.3　关于UDP协议的其他注意事项　203
14.6　向多台机器广播消息　203
14.7　SHOUTcast服务器　204
14.7.1　SHOUTcast协议　205
14.7.2　SHOUTcast服务器的工作机制　205
14.7.3　SHOUTcast服务器的伪代码　206
14.7.4　运行SHOUTcast服务器　211
14.8　进一步深入　212

第15章　ETS和DETS：大量数据的存储机制　213
15.1　表的基本操作　214
15.2　表的类型　214
15.3　ETS表的效率考虑　215
15.4　创建ETS表　216
15.5　ETS程序示例　217
15.5.1　三字索引迭代器　218
15.5.2　构造表　219
15.5.3　构造表有多快　219
15.5.4　访问表有多快　220
15.5.5　胜出的是……　220
15.6　DETS　222
15.7　我们没有提及的部分　224
15.8　代码清单　225

第16章　OTP概述　228
16.1　通用服务器程序的进化路线　229
16.1.1　server 1：原始服务器程序　229
16.1.2　server 2：支持事务的服务器程序　230
16.1.3　server 3：支持热代码替换的服务器程序　231
16.1.4　server 4：同时支持事务和热代码替换　233
16.1.5　server 5：压轴好戏　234
16.2　gen_server起步　236
16.2.1　第一步：确定回调模块的名称　237
16.2.2　第二步：写接口函数　237
16.2.3　第三步：编写回调函数　237
16.3　gen_server回调的结构　240
16.3.1　启动服务器程序时发生了什么　240
16.3.2　调用服务器程序时发生了什么　240
16.3.3　调用和通知　241
16.3.4　发给服务器的原生消息　241
16.3.5　Hasta la Vista, Baby(服务器的终止)　242
16.3.6　热代码替换　242
16.4　代码和模板　243
16.4.1　gen_server模板　243
16.4.2　my_bank　245
16.5　进一步深入　246

第17章　Mnesia：Erlang数据库　247
17.1　数据库查询　247
17.1.1　选取表中所有的数据　248
17.1.2　选取表中的数据　249
17.1.3　按条件选取表中的数据　249
17.1.4　从两个表选取数据(关联查询)　250
17.2　增删表中的数据　250
17.2.1　增加一行　251
17.2.2　删除一行　251
17.3　Mnesia事务　252
17.3.1　取消一个事务　253
17.3.2　加载测试数据　255
17.3.3　do()函数　255
17.4　在表中保存复杂数据　256
17.5　表的类型和位置　257
17.5.1　创建表　258
17.5.2　表属性的常见组合　259
17.5.3　表的行为　260
17.6　创建和初始化数据库　260
17.7　表查看器　261
17.8　进一步深入　262
17.9　代码清单　262

第18章　构造基于OTP的系统　266
18.1　通用的事件处理　267
18.2　错误日志　270
18.2.1　记录一个错误　270
18.2.2　配置错误日志　270
18.2.3　分析错误　274
18.3　警报管理　275
18.4　应用服务　277
18.4.1　素数服务　277
18.4.2　面积服务　278
18.5　监控树　279
18.6　启动整个系统　282
18.7　应用程序　285
18.8　文件系统的组织　287
18.9　应用程序监视器　288
18.10　进一步深入　289
18.11　我们如何创建素数　290

第19章　多核小引　292

第20章　多核编程　294
20.1　如何在多核的CPU上更有效率地运行　295
20.1.1　使用大量进程　295
20.1.2　避免副作用　295
20.1.3　顺序瓶颈　296
20.2　并行化顺序代码　297
20.3　小消息、大计算　300
20.4　映射—归并算法和磁盘索引程序　303
20.4.1　映射—归并算法　303
20.4.2　全文检索　307
20.4.3　索引器的操作　308
20.4.4　运行索引器　309
20.4.5　评论　310
20.4.6　索引器的代码　310
20.5　面向未来的成长　311

附录A　给我们的程序写文档　312
附录B　Microsoft Windows环境下的Erlang环境　316
附录C　资源　318
附录D　套接字应用程序　321
附录E　其他　335
附录F　模块和函数参考　351
索引　415

#Note#
{% highlight erlang %}

第1章　引言　1
1.1　路线图　1
1.2　正式起航　3
1.3　致谢　3
面向并行编程的杰出语言，由爱立信公司开发。 
 
第2章　入门　5
2.1　概览　5
2.1.1　阶段1：茫然无绪　5
2.1.2　阶段2：初窥门径　5
2.1.3　阶段2.5：观其大略，不求甚解　6
2.1.4　阶段3：运用自如　6
2.1.5　重中之重　6
2.2　Erlang安装　7
2.2.1　二进制发布版　7
2.2.2　从源代码创建Erlang　8
2.2.3　使用CEAN　8
关于ubuntu的安装，需要如下东西。
sudo apt-get install erlang, erlang-dev, erlang-x11, erlang-src, erlang-nox 
2.3　本书代码　8
2.4　启动shell　9
erl 
2.5　简单的整数运算　10
允许任意长度，解释器内部自动调整，类似于Ruby 
2.6　变量　11 
首子母要求大写 
2.6.1　变量不变　12
变量像代数里的变量一样只允许赋值一次，可以使用f()函数来forget all variable bindings 
赋过值的变量称为bound variable，否则称为unbound variable 
“=”在这里不是赋值操作符，而是模式匹配符 
在Erlang里一个变量只是一个值的引用，即一个指向存储值的区域的指针，而这个值不能被改变  
2.6.2　模式匹配　13
2.6.3　单一赋值为何有益于编写质量更高的代码　14
Erlang里变量不可变最大的好处利于多核编程，因为Erlang不像C或Java，它没有mutable state，所以没有shared memory，没有锁  
2.7　浮点数　15
类似于Ruby的浮点数 
2.8　原子　16
Atom用来表示非数字常量，它类似于C或Java里的枚举类型 
Atom以小写字母开始，后面接字母、下划线或@符 
Atom也可以用单引号括起来，这样就可以使用大写字母开头或带空格等的Atom 
Atom有点类似Ruby里的Symbol  
2.9　元组　17
2.9.1　创建元组　18
2.9.2　从元组中提取字段值　18
Tuple用来将一些元素分组，它使用大括号将元素括起来，并用逗号隔开 
Tuple类似于C里的structs，但Tuple是匿名的，而且Tuple里的fields没有名字 
Tuple里的items可以为任何类型，Tuple可以嵌套 
推荐做法是Tuple的第一个元素为一个Atom，这样可以清楚的描述该Tuple  
可以用匿名变量“_”作为占位符放在不想取值的地方
2.10　列表　19
2.10.1　术语　20
2.10.2　定义列表　20
2.10.3　从列表中提取元素　20
 List用来存放多个元素，它用中括号将元素括起来，并用逗号隔开 
List左边第一个元素我们称为head，剩下的元素组成的List称为tail 
例如对[1,2,3,4,5]，head为1，tail为[2,3,4,5] 
如果T为一个List，则[H|T]也是一个List，head为H，tail为T
2.11　字符串　21
Erlang里字符串必需用双引号括起来 
Erlang的字符串使用Latin-1(ISO-8859-1)字符集  
2.12　再论模式匹配　22

第3章　顺序型编程　24
3.1　模块　24
3.2　购物系统——进阶篇　28
3.3　同名不同目的函数　31
函数重载 
3.4　fun　31
匿名函数 
3.4.1　以fun为参数的函数　32
3.4.2　返回fun的函数　33
3.4.3　定义你自己的抽象流程控制　34
module用来声明本module名 
export用来导出本module的公开方法 
import用来导入其它module的公开方法  
3.5　简单的列表处理　35
3.6　列表解析　38
3.6.1　快速排序　39
3.6.2　毕达哥拉斯三元组　40
3.6.3　变位词　40
3.7　算术表达式　41
Op           Argument Type Priority  
+X               Number       1  
-X               Number       1  
X*Y              Number       2  
X/Y              Number       2  
bnot X           Integer      2  
X div Y          Integer      2  
X rem Y          Integer      2  
X band Y         Integer      2  
X+Y              Number       3  
X-Y              Number       3  
X bor Y          Integer      3  
X bxor Y         Integer      3  
X bsl N          Integer      3  
X bsr N          Integer      3  
 
3.8　断言　41
Guard是Erlang里的的一种表达式，关键字为when  
3.8.1　断言序列　42
Guard Sequence是一个或多个Guard，用“;”隔开 
G1;G2;...;Gn中至少有一个Guard为true的话则这个Guard Sequence为true 

Guard是一个或多个Guard表达式，用“,”隔开 
GuardExpr1,GuardExpr2,...,GuardExprN中所有Guard表达式都为true时为true 

合法的Guard表达式: 
1，The atom true 
2，Other constants(terms and bound variables)，all evaluate to false 
3，Calls to the guard predicates and to the BIFs 
4，Term comparisons 
5, Arithmetic expressions 
6, Boolean expressions 
7, Short-circuit boolean expressions  

3.8.2　断言样例　43
is_atom(X)  
is_binary(X)  
is_constant(X)  
is_float(X)  
is_function(X)  
is_function(X, N)  
is_integer(X)  
is_list(X)  
is_number(X)  
is_pid(X)  
is_port(X)  
is_reference(X)  
is_tuple(X)  
is_record(X, Tag)  
is_record(X, Tag, N)  
3.8.3　true断言的使用　44
if  
    Guard -> Expressions;  
    Guard -> Expressions;  
    ...  
    true -> Expressions  
end
 
abs(X)  
element(N, X)  
float(X)  
hd(X)  
length(X)  
node()  
node(X)  
round(X)  
self()  
size(X)  
trunc(X)  
tl(X)  
3.8.4　过时的断言函数　44
3.9　记录　44
Record用来给Tuple的元素起名字
-record(todo, {status=reminder, who=joe,text}).  
3.9.1　创建和更新记录　45
2> X=#todo{}.  
#todo{status = reminder, who = joe, text = undefined}  
3> X1=#todo{status=urgent, text="Fix errata in book"}.  
#todo{status = urgent, who = joe, text = "Fix errata in book"}  
4> X2=X1#todo{status=done}.  
#todo{status = done, who = joe, text = "Fix errata in book"}  
5> #todo{who=W, text=Txt} = X2.  
#todo{status = done, who = joe, text = "Fix errata in book"}  
6> W.  
joe  
7> Txt.  
"Fix errata in book"  
8> X2#todo.text.  
"Fix errata in book"  
3.9.2　从记录中提取字段值　45
3.9.3　在函数中对记录进行模式匹配　46
3.9.4　记录只是元组的伪装　46
Record的filed可以有默认值 
Record定义可以在Erlang源代码里或者放在外部.hrl文件里并被Erlang源代码所引入 
我们可以在Eshell里使用rr()方法来读取Record定义 

1> X.  
#todo{status = done, who = joe, text = "Fix errata in book"}  
2> rf(todo).  
ok  
3> X.  
{todo, done, joe, "Fix errata in book"}  

3.10　case/if表达式　46
3.10.1　case表达式　47
case Expression of  
    Pattern1 [when Guard1] -> Expr_seq1;  
    Pattern2 [when Guard2] -> Expr_seq2;  
    ...  
end  
3.10.2　if表达式　47
if  
    Guard1 ->  
        Expr_seq1;  
    Guard2 ->  
        Expr_seq2;  
    ...  
end
3.11　以自然顺序创建列表　48
3.12　累加器　48

第4章　异常　50
4.1　异常　50
4.2　抛出异常　51
4.3　try...catch　51
4.3.1　缩减版本　53
4.3.2　使用try...catch的编程惯例　53
4.4　catch　54
4.5　改进错误信息　55
4.6　try...catch的编程风格　55
4.6.1　经常会返回错误的程序　55
4.6.2　出错几率比较小的程序　56
4.7　捕获所有可能的异常　56
4.8　新老两种异常处理风格　56
4.9　栈跟踪　57
try FuncOrExpressionSequence of  
  Pattern1 [when Guard1] -> Expressions1;  
  Pattern2 [when Guard2] -> Expressions2;  
  ...  
catch  
  ExceptionType: ExPattern1 [when ExGuard1] -> ExExpressions1;  
  ExceptionType: ExPattern2 [when ExGuard2] -> ExExpressions2;  
  ...  
after  
  AfterExpressions  
end 
try FuncOrExpressionSequence of
  Pattern1 [when Guard1] -> Expressions1;
  Pattern2 [when Guard2] -> Expressions2;
  ...
catch
  ExceptionType: ExPattern1 [when ExGuard1] -> ExExpressions1;
  ExceptionType: ExPattern2 [when ExGuard2] -> ExExpressions2;
  ...
after
  AfterExpressions
end

exit(Why)  
throw(Why)  
erlang:error(Why)  
erlang:get_stacktrace()  

第5章　顺序型编程进阶　58
5.1　BIF　58
所有的BIFs都属于erlang module，如erlang:tuple_to_list()、erlang:time()，但是大部分BIFs都auto-imported了，所以可以直接调用tuple_to_list()、time() 
erlang module的所有BIFs列表见:http://www.erlang.org/doc/man/erlang.html  
5.2　二进制数据　58
@spec list_to_binary(loList) -> binary()  
@spec split_binary(Bin, Pos) -> {Bin1, Bin2}  
@spec term_to_binary(Term) -> Bin  
@spec binary_to_term(Bin) -> Term  
@spec size(Bin) -> Int
5.3　比特语法　60
5.3.1　16bit色彩的封包与解包　60
5.3.2　比特语法表达式　61
5.3.3　高级比特语法样例　62
5.4　小问题集锦　67
5.4.1　apply　68
5.4.2　属性　68
-module(modname).  
-import(Mod, [Name1/Arity1, Name2/Arity2,...]).  
-export([Name1/Arity1, Name2/Arity2,...]).  
-compile(Options).  
-vsn(Version).  
5.4.3　块表达式　71
5.4.4　布尔类型　71
5.4.5　布尔表达式　72
1> not true.  
false.  
2> true and flase.  
false.  
3> true or false.  
true  
4> true xor false.  
true  
5.4.6　字符集　72
Erlang源代码按ISO-8859-1(Latin-1)编码处理 
Erlang内部没有字符数据类型，字符串事实上并不存在而是由整数列表来表示 
Erlang对Unicode解析有限，因为整数列表有限 
5.4.7　注释　72
Erlang里的代码注释以%开始，为单行注释  
5.4.8　epp　73
在Erlang模块编译之前，Erlang的预处理器epp先处理它 
epp会扩展源代码里的macros并插入必要的头文件 
可以使用命令cmopile:file(M, ['P'])来编译M.erl并将结果输出到M.P文件里  
5.4.9　转义符　73
\b                     Backspace                  8  
\d                     Delete                     127  
\e                     Escape                     27  
\f                     Form feed                  12  
\n                     New line                   10  
\r                     Carriage return            13  
\s                     Space                      32  
\t                     Tab                        9  
\v                     Vertical tab               11  
\NNN \NN \N            Octal characters(N is 0..7)  
\^a..\^z or \^A..\^Z   Ctrl+A to Ctrl+Z           1 to 26  
\'                     Single quote               39  
\"                     Double quote               34  
\\                     Backslash                  92  
\C                     The ASCII code for C       An integer
5.4.10　表达式和表达式序列　74
5.4.11　函数引用　74 
5.4.12　包含文件　75
Erlang里被引入的文件的扩展名为.hrl 
-include(Filename).  
-include_lib("kernel/include/file.hrl").
5.4.13　列表操作符++和——　75
5.4.14　宏　76
-define(Constant, Replacement).  
-define(Func(Var1, Var2, .. , Var), Replacement).

当遇到形如?MacroName的表达式时Macros会被epp扩展
-define(macro1(X, Y), {a, X, Y}).  
  
foo(A) ->  
    ?macro1(A+10, b)

?FILE 当前文件名  
?MODULE 当前module名  
?LINE 当前行数 

-define(Macro).  
-undef(Macro).  
-ifdef(Macro).  
-ifndef(Macro).  
-else.  
-endif.

5.4.15　在模式中使用匹配操作符　77
5.4.16　数值类型　78
5.4.17　操作符优先级　79
5.4.18　进程字典　79
1> erase().  
[]  
2> put(x, 20).  
undefined  
3> get(x).  
20  
4> get().  
[{x, 20}]  
5> erase(x).  
20  
6> get(x).  
undefined  
5.4.19　引用　80
5.4.20　短路布尔表达式　80
Expr1 orelse Expr2  
Expr1 andalso Expr2
5.4.21　比较表达式　81
X > Y  
X < Y  
X =< Y  
X >= Y  
X == Y  
X /= Y  
X =:= Y  
X =/= Y  
5.4.22　下划线变量　82
_ 匿名变量 
第6章　编译并运行程序　83
6.1　开启和停止Erlang shell　83
6.2　配置开发环境　84
6.2.1　为文件加载器设定搜索路径　84
6.2.2　在系统启动时批量执行命令　85
6.3　运行程序的几种不同方法　86
6.3.1　在Erlang shell中编译运行　86
6.3.2　在命令提示符下编译运行　86
6.3.3　把程序当作escript脚本运行　88
6.3.4　用命令行参数编程　89
6.4　使用makefile进行自动编译　90
6.4.1　makefile模板　90
6.4.2　定制makefile模板　92
6.5　在Erlang shell中的命令编辑　93
6.6　解决系统死锁　93
6.7　如何应对故障　93
6.7.1　未定义/遗失代码　94
6.7.2　makefile不能工作　94
6.7.3　shell没有响应　95
6.8　获取帮助　96
6.9　调试环境　96
6.10　崩溃转储　97
启动和停止Eshell

   $ erl  
   1> halt().  

$ erl

1> halt().



查看/添加代码查找路径
code:get_path().
code:add_patha(Dir).
code:add_pathz(Dir).

erl -pa Dir1 -pa Dir2 ... -pz DirK1 -pz DirK2


查看载入的module和查看出错的module
code:all_loaded().
code:clash().

可以将code:add_patha()和code:add_pathz()扔到.erlang文件

运行Erl程序的几种方式:
hello.erl
  -module(hello).  
  -export([start/0]).  
    
  start() ->  
      io:format("Hello world~n").  
    
  %%%%%%%%%%%%%  
  $ erl  
  1> c(hello).  
  2> hello:start().  
  %%%%%%%%%%%%%  
  $ erlc hello.erl  
  $ erl -noshell -s hello start -s init stop  

-module(hello).
-export([start/0]).

start() ->
    io:format("Hello world~n").

%%%%%%%%%%%%%
$ erl
1> c(hello).
2> hello:start().
%%%%%%%%%%%%%
$ erlc hello.erl
$ erl -noshell -s hello start -s init stop



Quick Scripting
erl -eval 'io:format("Memory: ~p~n", [erlang:memory(total)]).' -noshell -s init stop


hello.sh
#!/bin/sh
erl -noshell -pa /home/joe/code -s hello start -s init stop

接受命令行参数
-module(main).
-export([main/1]).

fac(0) -> 1;
fac(N) -> N*fac(N-1).

main([A]) ->
  I = list_to_integer(atom_to_list(A)),
  F = fac(I),
  io:format("factorial ~w = ~w~n", [I, F]),
  init:stop().

%%%%%%%%%%%%
$ erlc main.erl
$ erl -noshell -s main main 25
factorial 25 = 15511210043330985984000000



使用Makefile构建Erl程序

% Makefile.template
# leave these lines alone
.SUFFIXED: .erl .beam .yrl

.erl.beam:
  erlc -W $<

.yrl.erl:
  erlc -W $<

ERL = erl -boot start_clean

# Here's a list of the erlang modules you want compiling
# If the modules don't fit onto one line add a \ character
# to the end of the lien and continue on the next line

# Edit the lines below
MODS = module1 module2 \
       module3 ... special1 ...\
       ...
       moduleN

# The first target in any makefile is the default target.
# If you just type "make" then "make all" is assumed (because
# "all" is the first target in this makefile)

all: compile

compile: ${MODS:%=%.beam} subdirs

## special compilation requirements are added here

special1.beam: special1.erl
  ${ERL} -Dflag1 -WO special1.erl

## run an application from the makefile

application1: compile
  ${ERL} -pa Dir1 -s application1 start Arg1 Arg2

# the subdirs target compiles any code in
# sub-directories

subdirs:
  cd dir1; make
  cd dir2; make
  ...

# remove all the code

clean:
  rm -rf *.beam erl_crash.dump
  cd dir1; make clean
  cd dir2; make clean


Getting Help
$ erl -man lists

如果Erlang crash掉了，它会生成一个erl_crash.dump文件，有一个基于Web的crash分析工具
   1> webtool:start().


第7章　并发　98
1. Erlang程序由许多进程组成，这些进程可以相互发送消息
2. 这些消息可能接收并理解也可能不接收不理解，如果你希望消息被接收并理解，你必须等待应答
3. 进程组可以连在一起，如果一组进程中的一个死掉，则该组的其他进程会收到一个说明那个进程为啥死掉的消息
第8章  并发编程　101
8.1　并发原语　101
1.创建和销毁进程非常快
2.进程间发送消息非常快
3.在所有的操作系统间进程行为一致
4.可以有大量的进程
5.进程不共享内存并且完全独立
6.与进程交互的唯一途径是发送消息  
8.2　一个简单的例子　102
Pid = spawn(Fun)  
  
Pid!Message  
  
receive  

  Pattern1 [when Guard1] ->  
    Expressions1;  
  Pattern2 [when Guard2] ->  
    Expressions2;  
  ...  
  after Time ->  
    Expressions  
end 
8.3　客户/服务器介绍　103
8.4　创建一个进程需要花费多少时间　107
8.5　带超时的receive　109
8.5.1　只有超时的receive　109
8.5.2　超时时间为0的receive　109
sleep(T) ->  
  receive  
  after T ->  
    true  
  end. 
8.5.3　使用一个无限等待超时进行接收　110
8.5.4　实现一个计时器　110
8.6　选择性接收　111
每个进程都有一个mailbox 
发送消息到该进程时，消息被放入mailbox 
当程序运行到receive语句时，启动一个timer 
读取mailbox中的第一条消息，匹配Pattern1，2，...，如果消息匹配了，则从mailbox中删除掉，并执行该Pattern后的表达式 
如果receive语句中没有匹配的Pattern，则将该消息从mailbox中删除并放入save queue，然后下一条消息进来匹配 
如果mailbox中没有一条消息是匹配成功的，则进程suspend并等待下一次新的消息进来，下次有新消息时save queue里的消息不会再匹配 
一旦有消息匹配，则已经放入save queue的消息按到达进程的顺序重新进入mailbox，如果设置了timer，则清空save queue 
如果在等待消息时timer到点，则执行ExpressionsTimeout表达式并将保存的消息按到达进程的顺序放入mailbox  
8.7　注册进程　112
register(AnAtom, Pid)  
unregister(AnAtom)  
whereis(AnAtom) -> Pid | undefined  
registered() -> [AnAtom::atom()]
8.8　如何编写一个并发程序　113
-module(ctemplate).  
-compile(export_all).  
  
start() ->  
  spawn(fun() -> loop([]) end).  
  
rpc(Pid, Request) ->  
  Pid ! {self(), Request},  
  receive  
    {Pid, Response} ->  
      Response  
  end.  
  
loop(X) ->  
  receive  
    Any ->  
      io:format("Received:~p~n", [Any]),  
      loop(X)  
  end.  
8.9　尾递归技术　114
在loop里receive之后马上又调用loop，则loop称为tail-recursive方法 
如果我们写一个方法F，F never returns，则需要确保在调用F之后不会调用其他方法，也不要将F用于List或Tuple的constructor，否则内存溢出 
8.10　使用MFA启动进程　115
spawn(Mod, FuncName, Args)
 使用Mod名、Func名和Args列表(成为一个MFA)来显式的调用spawn是确保系统动态加载代码(热修改)的正确方式 
spawn with funs则不会动态加载代码
8.11　习题　115

第9章　并发编程中的错误处理　116
9.1　链接进程　116
使用BIF link将两个节点连接起来，如果其中一个节点B退出，则另一个节点A会收到{'EXIT', B, Why}的信号
9.2　on_exit处理程序　117
可以创建一个on_exit(Pid, Fun)方法来捕获某个Pid进程的死掉:  
on_exit(Pid, Fun) ->  
  spawn(fun() ->  
      process_flag(trap_exit, true),  
      link(Pid),  
      receive  
        {'EXIT', Pid, Why} ->  
          Fun(Why)  
      end  
    end).  

9.3　远程错误处理　118
Erlang可以远程捕获和处理错误(跨机器) 
9.4　错误处理的细节　118
调用BIF process_flag(trap_exit, true)来将一个正常的进程转换为一个可以trap exits的系统进程   
9.4.1　捕获退出的编程模式　119
Pid = spawn(fun() -> ... end)   % 不关联 I Don't Care If a Process I Created Crashes
Pid = spawn_link(fun() -> ... end)  % 关联 I Want to Die If a Process I Created Crashes
%I Want to Handle Errors If a Process I Create Crashes
...  
process_flag(trap_exit, true),  
Pid = spawn_link(fun() -> ... end),  
...  
loop(...).  
  
loop(State) ->  
  receive  
    {'EXIT', SomePid, Reason} ->  
      %% do something with the error  
      loop(State1);  
    ...  
  end  
9.4.2　捕获退出信号(进阶篇)　120
9.5　错误处理原语　125
9.6　链接进程集　126
@spec spawn_link(Fun) -> Pid  
@spec process_flag(trap_exit, true)
@spec link(Pid) -> true  
@spec unlink(Pid) -> true  
@spec exit(Why) -> none()  
@spec exit(Pid, Why) -> true  
@spec erlang:monitor(process, Item) -> MonitorRef 
9.7　监视器　126
9.8　存活进程　127

第10章　分布式编程　128
10.1　名字服务　129
10.1.1　第一步：一个简单的名字服务　130
10.1.2　第二步：在同一台机器上，客户端运行于一个节点而服务器运行于第二个节点　131
10.1.3　第三步：让客户机和服务器运行于同一个局域网内的不同机器上　132
10.1.4　第四步：在因特网上的不同主机上分别运行客户机和服务器　133
10.2　分布式原语　134
10.3　分布式编程中使用的库　136
10.4　有cookie保护的系统　136
10.5　基于套接字的分布式模式　137
10.5.1　lib_chan　137
10.5.2　服务器代码　138
分布式程序指设计用于运行在网络中的可以通过消息传递相互交流彼此的活动的计算机上的程序

分布式应用的好处:Performance、Reliability、Scalability、Intrinsically distributed application、Fun

1. key-value server的简单例子:

-module(kvs).
-export([start/0, store/2, lookup/1]).

start() -> register(kvs, spawn(fun() -> loop() end)).

store(Key, Value) -> rpc({store, Key, Value}).

lookup(Key) -> rpc({lookup, Key}).

rpc(Q) ->
    kvs ! {self(), Q},
    receive
    {kvs, Reply} ->
        Reply
    end.

loop() ->
    receive
    {From, {store, Key, Value}} ->
        put(Key, {ok, Value}),
        From ! {kvs, true},
        loop();
    {From, {lookup, Key}} ->
        From ! {kvs, get(Key)},
        loop()
    end.
%%%%%%%%%
1> kvs:start().
true
2> kvs:store({location, joe}, "Stockholm").
true
3> kvs:store(weather, raining).
true
4> kvs:lookup(weather).
{ok,raining}
5> kvs:lookup({location, joe}).
{ok,"Stockhom"}
6> kvs:lookup({location, jane}).
undefined

2. 同一机器上Client-Server的key-value server例子:
$ erl -sname gandalf
(gandalf@loalhost) 1> kvs:start().
true

$ erl -sname bilbo
(bilbo@localhost) 1> rpc:call(gandalf@localhost, kvs, store, [weather, fine]).
true
(bilbo@localhost) 2> rpc:call(gandalf@localhost, kvs, lookup, [weather]).
{ok,fine}

(gandalf@loalhost) 2> kvs:lookup(weather).
{ok, fine}

3, 局域网内不同机器做Client-Server的key-value server例子:
doris $ erl -name gandalf -setcookie abc
(gandalf@doris.myerl.example.com) 1> kvs:start().
true

george $ erl -name bilbo -setcookie abc
(bilbo@george.myerl.example.com) 1> rpc:call(gandalf@doris.myerl.example.com, kvs, store, [weather, cold]).
true
(bilbo@george.myerl.example.com) 2> rpc:call(gandalf@doris.myerl.example.com, kvs, lookup, [weather]).
{ok, cold}

4, Internet上不同主机的Client-Server的key-value server的例子:
1)确保4369端口对TCP和UDP都开放，epmd(Erlang Port Mapper Daemon)这个程序需要使用该端口
2)如果想使用的端口为Min和Max，则确保这些端口也是打开的

$ erl -name ... -setcookie ... -kernel inet_dist_listen_min Min \
                                       inet_dist_listen_max Max


Distribution Primitives

@spec spawn(Node, Fun) -> Pid
@spec spawn(Node, Mod, Func, ArgList) -> Pid
@spec spawn_link(Node, Fun) -> Pid
@spec spawn_link(Node, Mod, Func, ArgList) -> Pid
@spec disconnect_node(Node) -> bool() | ignored
@spec monitor_node(Node, Flag) -> true
@spec node() -> Node
@spec node(Arg) -> Node
@spec nodes() -> [Node]
@spec is_alive() -> bool()
{RegName, Node} ! Msg

远程Spawning

-module(dist_demo).
-export([rpc/4, start/1]).

start(Node) ->
  spawn(Node, fun() -> loop() end).

rpc(Pid, M, F, A) ->
  Pid ! {rpc, self(), M, F, A},
  receive
    {Pid, Response} ->
      Response
  end.

loop() ->
  receive
    {rpc, Pid, M, F, A} ->
      Pid ! {self(), (catch apply(M, F, A))},
      loop()
  end.
%%%%%%%%%%%%
doris $ erl -name gandalf -setcookie abc
(gandalf@doris.myeerl.example.com) 1>

george $ erl -name bilbo -setcookie abc
(bilbo@george.myerl.example.com) 1>

(bilbo@george.myerl.example.com) 1> Pid = dist_demo:start('gandalf@doris.myerl.example.com').
<5094.40.0>

(bilbo@george.myerl.example.com) 1> dist_demo:rpc(Pid, erlang, node, []).
'gandalf@doris.myerl.example.com'



一般写分布式程序时不会直接用这些BIFs，而是使用一些封装好的libraries
rpc
global


rpc模块里最常用的方法是:
call(Node, Mod, Function, Args) -> Result|{badrpc, Reason}



对于分布式Erlang节点，它们必须使用cookie
cookie不会跨网络发送，而是仅仅用于初始化session认证
有三种设置cookie的方式:
1，在$HOME/.erlang.cookie文件里写入，然后chmod 400 .erlang.cookie只允许文件所有者访问
2，$ erl -setcookie AFRTY12ESS...，不安全，ps命令可以看到
3，erlang:set_cookie(node(), C)

分布式Erlang的主要问题是不安全，client可以在server机器上spawn任意进程，下面的调用会摧毁系统:
rpc:multicall(nodes(), os, cmd, ["cd /; rm -rf *"])


所以我们需要给出一定的限制，比如认证机制，lib_chan就是一个控制访问的库(作者自己在本书代码中写的一个库)
@spec start_server() -> true
配置文件默认为$HOME/.erlang/lib_chan.conf
@spec start_server(Conf) -> true
配置文件:
{port, NNNN}
{service,S,password,P,mfa,SomeMod,SomeFunc,SomeArgsS}

@spec connect(Host,Port,S,P,ArgsC) -> {ok, Pid} | {error, Whay}



例如如下配置文件
{port, 1234}.
{service, nameServer, password, "ABXy45", mfa, mod_name_server, start_me_up, notUsed}.



mod_name_server.erl
-module(mod_name_server).
-export([start_me_up/3]).

start_me_up(MM, _ArgsC, _ArgS) ->
  loop(MM).

loop(MM) ->
  receive
    {chan, MM, {store, K, V}} ->
      kvs:store(K, V),
      loop(MM);
    {chan, MM, {lookup, k}} ->
      MM ! {send, kvs:lookup(K)},
      loop(MM);
    {chan_closed, MM} ->
      true
  end.



试试:
   1. 起一个Erlang session作为server  
   2. 1> kvs:start().  
   3. true  
   4. 2> lib_chan:start_server().  
   5. Starting a port server on 1234...  
   6. true  
   7.   
   8. 另起一个Erlang session作为client  
   9. 1> {ok, Pid} = lib_chan:connect("localhost", 1234, nameServer, "ABXy45", "").  
  10. {ok, <0.43.0>}  
  11. 2> lib_chan:cast(Pid, {store, joe, "writing a book"}).  
  12. {send,{store,joe,"writing a book"}}  
  13. 3> lib_chan:rpc(Pid, {lookup, joe}).  
  14. {ok, "writing a book"}  
  15. 4> lib_chan:rpc( Pid, {lookup, jim}).  
  16. undefined 


change_group      Change group of a file.
change_owner      Change owner of a file.
change_time      Change the modification or last access time of a file.
close      Close a file.
consult      Read Erlang terms from a file.
copy      Copy file contents.
del_dir      Delete a directory.
delete      Delete a file.
eval      Evaluate Erlang expressions in a file.
format_error      Return a descriptive string for an error reason.
get_cwd      Get the current working directory.
list_dir      List files in a directory.
make_dir      Make a directory.
make_link      Make a hard link to a file.
make_symlink      Make a symbolic link to a file or directory.
open      Open a file.
position      Set position in a file.
pread      Read from a file at a certain position.
pwrite      Write to a file at a certain position.
read      Read from a file.
read_file      Read an entire file.
read_file_info      Get information about a file.
read_link      See what a link is pointing to.
read_link_info      Get information about a link or file.
rename      Rename a file.
script      Evaluate and return the value of Erlang expressions in a file.
set_cwd      Set the current working directory.
sync      Synchronize the in-memory state of a file with that on the physical medium.
truncate      Truncate a file.
write      Write to a file.
write_file      Write an entire file.
write_file_info      Change information about a file.
 
第14章　套接字编程　189
14.1　使用TCP　189
14.1.1　从服务器上获取数据　189
14.1.2　一个简单的TCP服务器　192
14.1.3　改进服务器　195
14.1.4　注意　196
14.2　控制逻辑　197
14.2.1　主动型消息接收(非阻塞)　197
14.2.2　被动型消息接收(阻塞)　198
14.2.3　混合型模式(半阻塞)　198
14.3　连接从何而来　199
14.4　套接字的出错处理　199
-module(socket_examples).
-compile(export_all).
-import(lists, [reverse/1]).

nano_get_url() ->
  nano_get_url("www.google.com").

nano_get_url(Host) ->
  {ok, Socket} = gen_tcp:connect(Host, 80, [binary, {packet, 0}]),
  ok = gen_tcp:send(Socket, "GET / HTTP/1.0\r\n\r\n"),
  receive_data(Socket, []).

receive_data(Socket, SoFar) ->
  receive
    {tcp, Socket, Bin} ->
      receive_data(Socket, [Bin|SoFar]);
    {tcp_closed, Socket} ->
      list_to_binary(reverse(SoFar))
  end.

start_nano_server() ->
  {ok, Listen} = gen_tcp:listen(2345, [binary, {packet, 4},
                                       {reuseaddr, true},
                                       {active, true}]),
  {ok, Socket} = gen_tcp:accept(Listen),
  gen_tcp:close(Listen),
  loop(Socket).

loop(Socket) ->
  receive
    {tcp, Socket, Bin} ->
      io:format("Server received binary = ~p~n", [Bin]),
      Str = binary_to_term(Bin),
      io:format("Server (unpacked) ~p~n", [Str]),
      Reply = string2value(Str),
      io:format("Server replying = ~p~n", [Reply]),
      gen_tcp:send(Socket, term_to_binary(Reply)),
      loop(Socket);
    {tcp_closed, Socket} ->
      io:format("Server socket closed~n")
  end.

nano_client_eval(Str) ->
  {ok, Socket} = 
    gen_tcp:connect("localhost", 2345, [binary, {packet, 4}]),
    ok = gen_tcp:send(Socket, term_to_binary(Str)),
    receive
      {tcp, Socket, Bin} ->
        io:format("Client received binary = ~p~n", [Bin]),
        Val = binary_to_term(Bin),
        io:format("Client result = ~p~n", [Val]),
        gen_tcp:close(Socket)
    end.

string2value(Str) ->
    {ok, Tokens, _} = erl_scan:string(Str ++ "."),
    {ok, Exprs} = erl_parse:parse_exprs(Tokens),
    Bindings = erl_eval:new_bindings(),
    {value, Value, _} = erl_eval:exprs(Exprs, Bindings),
    Value.
 
- show quoted text -
-module(ets_test).

-export([start/0]).

start() ->
  lists:foreach(fun test_ets/1,
    [set, ordered_set, bag, duplicate_bag]).

test_ets(Mode) ->
  TableId = ets:new(test, [Mode]),
  ets:insert(TableId, {a,1}),
  ets:insert(TableId, {b,2}),
  ets:insert(TableId, {a,1}),
  ets:insert(TableId, {a,3}),
  List = ets:tab2list(TableId),
  io:format("~-13w => ~p~n", [Mode, List]),
  ets:delete(TableId).
 
- show quoted text -
%% 
%%  Excerpted from "Programming Erlang",
%%  published by The Pragmatic Bookshelf.
%%  Copyrights apply to this code. It may not be used to create training material, 
%%  courses, books, articles, and the like. Contact us if you are in doubt.
%%  We make no guarantees that this code is fit for any purpose. 
%%  Visit http://www.pragmaticprogrammer.com/titles/jaerlang for more book information.
%%
-module(test_mnesia).
-import(lists, [foreach/2]).
-compile(export_all).

%% IMPORTANT: The next line must be included
%%            if we want to call qlc:q(...)

-include_lib("stdlib/include/qlc.hrl").
-record(shop, {item, quantity, cost}).
-record(cost, {name, price}).
-record(design, {id, plan}).

do_this_once() ->
    mnesia:create_schema([node()]),
    mnesia:start(),
    mnesia:create_table(shop,   [{attributes, record_info(fields, shop)}]),
    mnesia:create_table(cost,   [{attributes, record_info(fields, cost)}]),
    mnesia:create_table(design, [{attributes, record_info(fields, design)}]),
    mnesia:stop().

start() ->
    mnesia:start(),
    mnesia:wait_for_tables([shop,cost,design], 20000).

%% SQL equivalent
%%  SELECT * FROM shop;
demo(select_shop) ->
    do(qlc:q([X || X <- mnesia:table(shop)]));

%% SQL equivalent
%%  SELECT item, quantity FROM shop;
demo(select_some) ->
    do(qlc:q([{X#shop.item, X#shop.quantity} || X <- mnesia:table(shop)]));

%% SQL equivalent
%%   SELECT shop.item FROM shop
%%   WHERE  shop.quantity < 250;
demo(reorder) ->
    do(qlc:q([X#shop.item || X <- mnesia:table(shop),
                 X#shop.quantity < 250
                ]));

%% SQL equivalent
%%   SELECT shop.item, shop.quantity, cost.name, cost.price
%%   FROM shop, cost 
%%   WHERE shop.item = cost.name 
%%     AND cost.price < 2
%%     AND shop.quantity < 250
demo(join) ->
    do(qlc:q([X#shop.item || X <- mnesia:table(shop),
                 X#shop.quantity < 250,
                 Y <- mnesia:table(cost),
                 X#shop.item =:= Y#cost.name,
                 Y#cost.price < 2
                ])).

do(Q) ->
    F = fun() -> qlc:e(Q) end,
    {atomic, Val} = mnesia:transaction(F),
    Val.

example_tables() ->
    [%% The shop table
     {shop, apple,   20,   2.3},
     {shop, orange,  100,  3.8},
     {shop, pear,    200,  3.6},
     {shop, banana,  420,  4.5},
     {shop, potato,  2456, 1.2},
     %% The cost table
     {cost, apple,   1.5},
     {cost, orange,  2.4},
     {cost, pear,    2.2},
     {cost, banana,  1.5},
     {cost, potato,  0.6}
    ].

add_shop_item(Name, Quantity, Cost) ->
    Row = #shop{item=Name, quantity=Quantity, cost=Cost},
    F = fun() ->
      mnesia:write(Row)
    end,
    mnesia:transaction(F).

remove_shop_item(Item) ->
    Oid = {shop, Item},
    F = fun() ->
        mnesia:delete(Oid)
    end,
    mnesia:transaction(F).

farmer(Nwant) ->
    %% Nwant = Number of oranges the farmer wants to buy
    F = fun() ->
        %% find the number of apples
        [Apple] = mnesia:read({shop,apple}),
        Napples = Apple#shop.quantity,
        Apple1  = Apple#shop{quantity = Napples + 2*Nwant},
        %% update the database
        mnesia:write(Apple1),
        %% find the number of oranges
        [Orange] = mnesia:read({shop,orange}),
        NOranges = Orange#shop.quantity,
        if 
            NOranges >= Nwant ->
            N1 =  NOranges - Nwant,
            Orange1 = Orange#shop{quantity=N1},
            %% update the database
            mnesia:write(Orange1);
            true ->
            %% Oops -- not enough oranges
            mnesia:abort(oranges)
        end
    end,
    mnesia:transaction(F).

reset_tables() ->
    mnesia:clear_table(shop),
    mnesia:clear_table(cost),
    F = fun() ->
        foreach(fun mnesia:write/1, example_tables())
    end,
    mnesia:transaction(F).

add_plans() ->
    D1 = #design{id   = {joe,1},
         plan = {circle,10}},
    D2 = #design{id   = fred, 
         plan = {rectangle,10,5}},
    D3 = #design{id   = {jane,{house,23}},
         plan = {house,
             [{floor,1,
               [{doors,3},
                {windows,12},
                {rooms,5}]},
              {floor,2,
               [{doors,2},
                {rooms,4},
                {windows,15}]}]}},
    F = fun() -> 
        mnesia:write(D1),
        mnesia:write(D2),
        mnesia:write(D3)
    end,
    mnesia:transaction(F).

get_plan(PlanId) ->
    F = fun() -> mnesia:read({design, PlanId}) end,
    mnesia:transaction(F). 


第15章　ETS和DETS：大量数据的存储机制　213
15.1　表的基本操作　214
15.2　表的类型　214
15.3　ETS表的效率考虑　215
15.4　创建ETS表　216
15.5　ETS程序示例　217
15.5.1　三字索引迭代器　218
15.5.2　构造表　219
15.5.3　构造表有多快　219
15.5.4　访问表有多快　220
15.5.5　胜出的是……　220
15.6　DETS　222
15.7　我们没有提及的部分　224
15.8　代码清单　225
@spec ets:new(Name, [Opt]) -> TableId
    Name is an atom. [Opt] is a list of options, taken from the following:
    set | ordered_set | bag | duplicate_bag
          Create an ETS table of the given type (we talked about these
          earlier).
    private
          Create a private table. Only the owner process can read and
          write this table.
    public
          Create a public table. Any process that knows the table iden-
          tifier can read and write this table.
    protected
          Create a protected table. Any process that knows the table
          identifier can read this table, but only the owner process can
          write to the table.
    named_table
          If this is present, then Name can be used for subsequent table
          operations.
    {keypos, K}
          Use K as the key position. Normally position 1 is used for the
          key. Probably the only time when we would use this option
          is if we store an Erlang record (which is actually a disguised
          tuple), where the first element of the record contains the
          record name.
    Note: Opening an ETS table with zero options is the same as opening it
with the options [set,protected,{keypos,1}].

Create a new table or open an existing table.
     This we do with ets:new or dets:open_file.
Insert a tuple or several tuples into a table.
     Here we call insert(Tablename, X), where X is a tuple or a list of
     tuples. insert has the same arguments and works the same way in
     ETS and DETS.
Look up a tuple in a table.
     Here we call lookup(TableName, Key). The result is a list of tuples
     that match Key. lookup is defined for both ETS and DETS.
     (Why is the return value a list of tuples? If the table type is a “bag,”
     then several tuples can have the same key. We’ll look at the table
     types in the next section.)
     If no tuples in the table have the required key, then an empty list
     is returned.
Dispose of a table.
     When we’ve finished with a table, we can tell the system by calling
     dets:close(TableId) or ets:delete(TableId).

第16章　OTP概述　228
16.1　通用服务器程序的进化路线　229
16.1.1　server 1：原始服务器程序　229
16.1.2　server 2：支持事务的服务器程序　230
16.1.3　server 3：支持热代码替换的服务器程序　231
16.1.4　server 4：同时支持事务和热代码替换　233
16.1.5　server 5：压轴好戏　234
16.2　gen_server起步　236
16.2.1　第一步：确定回调模块的名称　237
16.2.2　第二步：写接口函数　237
16.2.3　第三步：编写回调函数　237
16.3　gen_server回调的结构　240
16.3.1　启动服务器程序时发生了什么　240
16.3.2　调用服务器程序时发生了什么　240
16.3.3　调用和通知　241
16.3.4　发给服务器的原生消息　241
16.3.5　Hasta la Vista, Baby(服务器的终止)　242
16.3.6　热代码替换　242
16.4　代码和模板　243
16.4.1　gen_server模板　243
16.4.2　my_bank　245
16.5　进一步深入　246
一套优秀的Erlang服务框架，利用绑定回调机制实现相关操作。 
{% endhighlight %}
