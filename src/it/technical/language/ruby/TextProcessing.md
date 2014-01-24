---
title: 文本处理
---

# 整体介绍

*本文主要是对<Ruby最佳实践>文本处理内容的再次复习*.
具体读书笔记见[douban](http://book.douban.com/people/qianjigui/annotation/4214148/).

该章节目录如下:

```ruby
4. Text Processing and File Management
Line-Based File Processing with State Tracking
Regular Expressions
    Don’t Work Too Hard
    Anchors Are Your Friends
    Use Caution When Working with Quantifiers
Working with Files
    Using Pathname and FileUtils
The tempfile Standard Library
    Automatic Temporary Directory Handling
    Collision Avoidance
    Same Old I/O Operations
    Automatic Unlinking
Text-Processing Strategies
    Advanced Line Processing
    Atomic Saves
Conclusions
```

文中主要涉及如下处理方法与手段:
- 基于行的状态处理
- 正则表达式
- 文件处理的相关API
- 临时文件API
- 主要处理策略

# 具体实践方案

## 基于行的带有状态的处理
主要特征如下:
- 通过一个完整的Context记录整体分析状态, 可以借助栈等数据结构进行有序支持.
- 每行有具体特征符号用于识别
- 利用状态机进行有上下关联的整合
- 对其它文本的报警与skip

其实现的一般结构如下:

```ruby
case section
when [xxx,xxx]
   process
when [xxx,xxx]
   process
else
   process
end
```
## 基于正则表达式的处理

充分利用正则表达式的特性, 特别是 锚点, 分组与捕获.

关于正则表达式的详细API见[Regular](<%=(Regular)l%>)

## 文件处理的API

- Pathname, Ruby 1.9
    - 支持大量关于路径的操作与关系运算
- FileUtils, Ruby 1.8

## tempfile API
通过tempfile进行中间状态的保存与过渡.

tempfile API 内部具有与File类似的API, 并且可以防止文件操作的冲突.

自动删除有两种: 一种是unlink!, 直接删除; 一种是unlink, GC时处理.

## 文本处理的一般策略

### Enumerator
迭代器: 逐行处理, 行号访问

```ruby
f=File.open
f.each
f.lineno
```

### 原子化操作

利用tempfile API进行中间过程的处理, 再通过mv进行保存.
