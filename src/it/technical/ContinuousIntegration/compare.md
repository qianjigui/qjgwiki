---
title: 系统变更比对方法
tags: Tool
---

# 一般思路
1. 对比资源创建与组装
    1. 各种文件格式的支持
2. 目录对比
    1. 不同文件类型的比对
3. 结果汇总与反馈
    1. 关注结果的过滤与高亮

# 具体实现
## 数据包解压

### zip



```shell
unzip -d destination aaa.zip
```

### boot.img

boot.img: u-boot legacy uImage, Linux-3.4.35_s40, Linux/ARM, OS Kernel Image (Not compressed)

- [ubootExtractTool](http://ftp.maddes.net/u-boot/)
- [zImageUnzip](http://forum.xda-developers.com/showthread.php?t=901152)

```shell
```


## 目录级对比

```shell
diff -rq tmp/1228/ tmp/0107/ | sort | uniq | grep -v \.svn
```
