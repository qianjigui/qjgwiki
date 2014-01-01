---
title: "MercurialSCM使用知识"
tags: Tool
---




#MercurialSCM#
##Add a footprint for a url##
  1. 获取fingerprint(注意空格位置等):

```bash
openssl s_client -connect <host>:<port> < /dev/null 2>/dev/null | openssl x509 -fingerprint -noout -in /dev/stdin
```

  1. 在~/.hgrc文件的hostfingerprints部分添加一行: host=fingerprint

##Ubuntu hg-git plugin 配置##
[修复方法](https://bugs.launchpad.net/ubuntu/+source/hg-git/+bug/666292)
添加如下信息到~/.hgrc:

```bash 
[extensions]
hgext.bookmarks =
hggit = /usr/share/pyshared/hgext/git
```


从本地文件夹转移过来，需要将git文件夹名字改为XXX.git.
[本地同步](http://stackoverflow.com/questions/5785158/mercurial-hg-git-clone-from-a-local-directory)

##hgrc##
[配置详解](http://www.selenic.com/mercurial/hgrc.5.html)

认真利用:
  1. .hg/hgrc
  1. 缩写路径，存储登录帐号与密码:


```bash
[paths]
default = https://code.google.com/p/project/default
gitserver = git+ssh://xxxx@demo.com/directory/github/xxx.git

[auth]
googlecode.prefix=https://code.google.com/p/project/default
googlecode.password=password
googlecode.username=username

gitserver.prefix=git+ssh://xxxx@demo.com/directory/github/xxx.git
gitserver.password=password
gitserver.username=username
```

