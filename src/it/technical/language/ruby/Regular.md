---
title: Ruby 正则表达式
tags: Regular
tagline: 让正则表达式来优化字符串处理
---

*声明: 下列内容基于ruby 2.0.0p247 (2013-06-27) [x86_64-linux]*

# 一堆小例子

## 基本使用

```ruby
/hay/ =~ 'haystack'   #=> 0
%r[y].match('haystack') #=> #<MatchData "y">
```

# 主要概念
## New a object
```ruby
# matching check
=~

# MatchData
obj=regexpObject.match(stringobj)

# Regexp class
r1 = Regexp.new('^a-z+:\s+\w+') #=> /^a-z+:\s+\w+/
r2 = Regexp.new('cat', true)     #=> /cat/i
r3 = Regexp.new(r2)              #=> /cat/i
r4 = Regexp.new('dog', Regexp::EXTENDED | Regexp::IGNORECASE) #=> /dog/ix
```

## 字符组 Character Classes
### 通用表示
| 符号 | English | 中文 |
|------|---------|------|
| `/./`|  Any character except a newline.
| `/./m` | Any character (the m modifier enables multiline mode)
| `/\w/` | A word character ([a-zA-Z0-9_])
| `/\W/` | A non-word character ([^a-zA-Z0-9_]). Please take a look at Bug #4044 if using /\W/ with the /i modifier.
| `/\d/` | A digit character ([0-9])
| `/\D/` | A non-digit character ([^0-9])
| `/\h/` | A hexdigit character ([0-9a-fA-F])
| `/\H/` | A non-hexdigit character ([^0-9a-fA-F])
| `/\s/` | A whitespace character: /[ \t\r\n\f]/
| `/\S/` | A non-whitespace character: /[^ \t\r\n\f]/

# 参考资料
[Ruby Regular RDoc](http://www.ruby-doc.org/core-2.1.0/Regexp.html)
[Ruby 正则表达式官方文档翻译参照](http://blog.chinaunix.net/uid-298861-id-3144205.html)
