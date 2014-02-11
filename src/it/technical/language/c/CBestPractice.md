---
title: C 语言最佳实践
---

# 沙箱运行模式

## 解决场景

- 不影响原运行环境
- 获取运行结果状态

## 具体实现细节

- 父进程准备好*前文的状态*
- 通过`fork`调用子进程
- 子进程处理
- 父进程通过`waitpid`进行等待, 并根据返回结果处理后续工作

<script src="http://gist.github.com/qianjigui/8644808.js"></script>

# 上下文维持

## 解决场景
- 防止程序重入
- Context 维持最简洁

## 具体实现细节

- 在实现时, 需要考虑根据*持久化数据*的状态.
- 步骤与任务间可以串行运行, 各任务间通过*事务*的概念进行统一管理.
- 在这种情况下, 事务实现时需要保证*可回滚*.

<script src="https://gist.github.com/qianjigui/8663359.js"></script>



# 网络通信处理

# Log

## Android NDK logger

<script src="https://gist.github.com/qianjigui/8910802.js"></script>

