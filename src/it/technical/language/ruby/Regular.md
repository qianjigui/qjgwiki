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
| 符号 | English | 备注 |
|------|---------|------|
| `/./`|  Any character except a newline. | 除新行外的所有字符             |
| `/./m` | Any character (the m modifier enables multiline mode) | 带多行支持后,表示所有字符  |
| `/\w/` | A word character (`[a-zA-Z0-9_]`) |    |
| `/\W/` | A non-word character (`[^a-zA-Z0-9_]`). Please take a look at Bug #4044 if using /\W/ with the /i modifier. |              |
| `/\d/` | A digit character (`[0-9]`) |              |
| `/\D/` | A non-digit character (`[^0-9]`) |              |
| `/\h/` | A hexdigit character (`[0-9a-fA-F]`) |              |
| `/\H/` | A non-hexdigit character (`[^0-9a-fA-F]`) |              |
| `/\s/` | A whitespace character: /`[ \t\r\n\f]`/ |              |
| `/\S/` | A non-whitespace character: /`[^ \t\r\n\f]`/ |              |

### POSIX
| 符号 | English | 备注 |
|------|---------|------|
| `/[[:alnum:]]/`|  Alphabetic and numeric character | |
| `/[[:alpha:]]/`|  Alphabetic character | |
| `/[[:blank:]]/`|  Space or tab | |
| `/[[:cntrl:]]/`|  Control character | |
| `/[[:digit:]]/`|  Digit | |
| `/[[:graph:]]/`|  Non-blank character (excludes spaces, control characters, and similar) | |
| `/[[:lower:]]/`|  Lowercase alphabetical character | |
| `/[[:print:]]/`|  Like `[:graph:]`, but includes the space character | |
| `/[[:punct:]]/`|  Punctuation character | |
| `/[[:space:]]/`|  Whitespace character (`[:blank:]`, newline, carriage return, etc.) | |
| `/[[:upper:]]/`|  Uppercase alphabetical | |
| `/[[:xdigit:]]/`|  Digit allowed in a hexadecimal number (i.e., 0-9a-fA-F) | |

### non-POSIX
| 符号 | English | 备注 |
|------|---------|------|
| `/[[:word:]]/`|  A character in one of the following Unicode general categories Letter, Mark, Number, Connector_Punctuation | |
| `/[[:ascii:]]/`|  A character in the ASCII character set | |

# 参考资料
- [Ruby Regular RDoc](http://www.ruby-doc.org/core-2.1.0/Regexp.html)
- [Ruby 正则表达式官方文档翻译参照](http://blog.chinaunix.net/uid-298861-id-3144205.html)
