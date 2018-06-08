---
title: "Linux/Ubuntu 使用知识"
tags: 
---



#Ubuntu#

##常识##
###用户态与内核态###
这个网上讨论很多，从编程角度看：调用内核函数的为内核态，其他可以看作用户态。
time指令中的标准输出就是由：墙上时间、用户态调用、内核态调用三部分时间组成。

一个已经安装的系统的支持的所有的系统调用可以在*/usr/include/bits/syscall.h*文件里面看到。

##基本操作##

##Mercurial SCM##
[MercurialSCM使用知识](<%=(../ContinuousIntegration/mercurial)l%>)

##Firefox打印问题##
很多时候，页面被不正常的分页或者打印内容不全等一系列问题的时候，可以考虑检查css代码。

* overflow 需要关闭
* padding/margin 需要调节

##网络设置##
###VPN###
Ubuntu [需要设置个把属性](http://ubuntuforums.org/showthread.php?p=7002673):
需要让PPTP拒绝EAP验证，而这个设置在VPN设置栏中没有。
需要通过手工进行处理:
1. 打开gconf-editor
2. 进入到 /system/networking/connections
3. 查看并找到VPN文件夹
4. 添加新的键值
5. Name: refuse-eap
6. Type: string
7. Value: yes
8. 保存、退出并重新连接

日志信息，从错误到成功:

```bash
pppd[5094]: pppd 2.4.5 started by root, uid 0
pppd[5094]: Using interface ppp0
pppd[5094]: Connect: ppp0 <--> /dev/pts/2
pppd[5094]: LCP terminated by peer (WM--^Al^@<M-Mt^@^@^CM-")
pppd[5094]: Connection terminated.
pppd[5094]: Modem hangup
pppd[5094]: Exit.
pppd[5238]: Plugin /usr/lib/pppd/2.4.5//nm-pptp-pppd-plugin.so loaded.
pppd[5238]: pppd 2.4.5 started by root, uid 0
pppd[5238]: Using interface ppp0
pppd[5238]: Connect: ppp0 <--> /dev/pts/2
pppd[5238]: LCP: timeout sending Config-Requests
pppd[5238]: Connection terminated.
pppd[5238]: Modem hangup
pppd[5238]: Exit.
pppd[5427]: Plugin /usr/lib/pppd/2.4.5//nm-pptp-pppd-plugin.so loaded.
pppd[5427]: pppd 2.4.5 started by root, uid 0
pppd[5427]: Using interface ppp0
pppd[5427]: Connect: ppp0 <--> /dev/pts/2
pppd[5427]: CHAP authentication succeeded
kernel: [20287.732748] PPP BSD Compression module registered
kernel: [20287.768881] PPP Deflate Compression module registered
pppd[5427]: local  IP address 172.0.0.18
pppd[5427]: remote IP address 172.0.0.1
pppd[5427]: primary   DNS address 20x.1x5.xxx.xxx
pppd[5427]: secondary DNS address 20x.1x5.xxx.xxx
```

另外就是如果前端有个不怎么给力的路由器，请设置DMZ主机为后端VPN使用的PC机。

##屏幕问题##

###开机黑屏/中途使用突然黑屏###
网上也有很多材料谈到，目前确实不知道这类问题产生的真正原因。

查错的困难:
由于笔记本突然黑屏，我技术水平还不是很过硬，不能够在完全黑屏的情况下导出系统日志，也就不能够通过日志的方法进行排查。另一方面这种错误是随机出现的，发现后做应急处理的程序不完备。

由于上面的错误，我在做系统差错时，多是采用外部的观察:

* 指示灯: 在启动时黑屏，系统和平常进入登陆界面一样，硬盘灯先是不断闪烁，然后就停止闪烁了。估计是已经加载完毕登陆界面等待输入用户信息。中途黑屏时，多为一直闪烁。
* CPU风扇声音: 启动时和平常声音相同，系统中间进入黑屏时多是高速运转。

那么导致上述现象的原因可能是什么呢？

综合了网上多是配置启动系统内核的显卡模块参数，我觉得:
系统的电源管理系统出现了一些问题，不正常的向系统发送信号(进入休眠状态)，系统关闭屏幕，并将数据拷入swap分区。但是由于我的及其的休眠状态有问题，导致一直无法进入。

由于以上问题，我把问题定位到了ACPI(高级电源管理接口)上面。可能是由于它的错误控制导致了系统在开机时将视频信号输出到其他端口，而在运行过程中又将错误信号发给了系统导致了挂起。

配置ACPI http://www.brighthub.com/computing/linux/articles/39504.aspx :
主要是通过在grub加载时向内核发送参数来控制ACPI模块的加载:

* `bashacpi=off`: 关闭ACPI的支持
* `bash acpi=ht`: 关闭除超线程之外的ACPI支持
* `bash pci=noacpi`: 关闭ACPI的硬中断并且PCI不再扫描ACPI
* `bash acpi=noirq`: 关闭ACPI的IRQ(硬中断)

而我是直接采用 `pci=noacpi`。
休眠、挂起、待机的区别:

* 挂起是一种省电模式，系统将机器的硬盘、显示器等外部设备停止工作，而CPU、内存仍然工作，等待用户随时唤醒。
* 体眠是一种更加省电的模式，它将内存中的数据保存于硬盘中，使CPU也停止工作，当再次使用时需按开关机键，机器将会恢复到您的执行休眠时的状态，而不用再次执行启动这个复杂的过程。
* 待机是将当前处于运行状态的数据保存在内存中，机器只对内存供电，而硬盘、屏幕和CPU等部件则停止供电。由于数据存储在速度快的内存中，因此进入等待状态和唤醒的速度比较快。不过这些数据是保存在内存中 ，如果断电则会使数据丢失。

# ubuntu 10.04常用命令
## 升级 firefox

```shell
sudo add-apt-repository ppa:ubuntu-mozilla-security/ppa
sudo apt-get update
sudo apt-get install firefox
```

# Linux 管理常用指令

```
# Mount相关
sudo apt-get install cifs-utils
sudo mount -t cifs -o uid=1000,username=administrator,passwd=system009 //10.9.5.20/share Your_local_path

 

# File相关
# 创建一个文件大小为file_size
dd if=/dev/zero of=upload_test bs=file_size(in bytes) count=1

  

# Server Manager
sudo useradd username -m -s /bin/bash
sudo passwd username
sudo adduser username sudo

# scp 本地用户名 @IP 地址 : 文件名 1 远程用户名 @IP 地址 : 文件名 2 
# delete user and home directory:
sudo deluser --remove-home username

#添加sudo免密码

```
vim /etc/sudoers
jenkins ALL=(ALL) NOPASSWD: ALL
```
   

# key

创建keystore：keytool -genkey -alias test.keystore -keyalg RSA -validity 10000 -keystore test.keystore
查看keystore：keytool -list  -v -keystore "C:\sign\bin1\test.keystore"
签名: jarsigner -keystore test.keystore -storepass test.test -keypass test.test -signedjar t.lar t.apk test.keystore

    

tar

ls -l | grep ^[^d] | awk '{print $8}' | tar czfhv snod.tar.gz -T -

Diff
#diff a directory with git format and ignore .git directory

diff -r -u -x '.git' aaaa/packages/apps/PackageInstaller bbb/packages/apps/PackageInstaller
```

版本号相关规范
http://www.cnblogs.com/sdjxcolin/archive/2007/07/02/803376.html

MediaWiki change main page: MediaWiki:Mainpage
How to change the user privileges in MediaWiki?
The privileges for existing users can be modified by logging in to your MediaWiki as administrator and going to Special Pages. 
Then, under Restricted special pages, click User rights management.
Enter the username which you wish to modify and click the Edit User Groups button. Next, select the desired rights listed under Available groups and click the Save User Groups button.
