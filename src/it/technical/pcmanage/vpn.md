---
title: Ubuntu 10.04 安装 VPN
tags: 
tagline: 安全才能回家 :-)
---

# 企业 Cisco VPN 安装与配置使用

## 基本步骤

整体分为多步：

1. 在企业中申请VPN
2. 安装Cisco VPN客户端，本文针对Cisco AnyConnect VPN
3. *重启系统*

    开始调试了半天, 最后发现需要重新启动系统. 估计是涉及到驱动程序了需要重新load

4. 添加VPN
5. 配置VPN
6. 点击连接，输入username&password
7. Connect & Use

## 图示

![Install APP](http://pic.yupoo.com/qianjigui/Dr6AnrCz/medish.jpg)
![Create VPN](http://pic.yupoo.com/qianjigui/Dr6yOOGr/medish.jpg)
![Setup VPN](http://pic.yupoo.com/qianjigui/Dr6AnTj9/medish.jpg)
![Connect](http://pic.yupoo.com/qianjigui/Dr6Ao37w/medish.jpg)


# P2P VPN

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

