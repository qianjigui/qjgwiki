---
title: Jenkins 构建与集成技术
tags: Docker CI
---

# 系统研发的开发与服务构建

## 组成部分

* 代码托管服务
* 代码编译服务

### 编译服务

要求:

* 做到上下文隔离
* 自动化程度高

## 编译环境搭建注意点

1. 账号与权限的配置
2. 时区的配置 `sudo apt-get install tzdata`
3. 系统编码的配置

```
LANG=en_US.UTF-8
LANGUAGE=en_US.UTF-8
LC_CTYPE="en_US.UTF-8"
LC_NUMERIC="en_US.UTF-8"
LC_TIME="en_US.UTF-8"
LC_COLLATE="en_US.UTF-8"
LC_MONETARY="en_US.UTF-8"
LC_MESSAGES="en_US.UTF-8"
LC_PAPER="en_US.UTF-8"
LC_NAME="en_US.UTF-8"
LC_ADDRESS="en_US.UTF-8"
LC_TELEPHONE="en_US.UTF-8"
LC_MEASUREMENT="en_US.UTF-8"
LC_IDENTIFICATION="en_US.UTF-8"
LC_ALL=en_US.UTF-8
```

# 外部工具集合

1. Gerrit/Jenkins Rest调用工具

# 管理技巧

## https://stackoverflow.com/questions/10238604/how-to-shutdown-my-jenkins-safely

服务detach: ctrl-p ctrl-q
