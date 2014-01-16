---
title: git常用技巧
tags:
---

# Patch

## 纯文本

```shell
git diff > a.patch
```

## 综合

```shell
# The last commit change
git format-patch HEAD^..HEAD
```
