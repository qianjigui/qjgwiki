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

### 扩展字符集合 Character Properties

| 符号 | English | 备注 |
|------|---------|------|
| `/\p{Alnum}/` | Alphabetic and numeric character | |
| `/\p{Alpha}/` | Alphabetic character | |
| `/\p{Blank}/` | Space or tab | |
| `/\p{Cntrl}/` | Control character | |
| `/\p{Digit}/` | Digit | |
| `/\p{Graph}/` | Non-blank character (excludes spaces, control characters, and similar) | |
| `/\p{Lower}/` | Lowercase alphabetical character | |
| `/\p{Print}/` | Like \p{Graph}, but includes the space character | |
| `/\p{Punct}/` | Punctuation character | |
| `/\p{Space}/` | Whitespace character ([:blank:], newline, carriage return, etc.) | |
| `/\p{Upper}/` | Uppercase alphabetical | |
| `/\p{XDigit}/` | Digit allowed in a hexadecimal number (i.e., 0-9a-fA-F) | |
| `/\p{Word}/` | A member of one of the following Unicode general category Letter, Mark, Number, Connector_Punctuation | |
| `/\p{ASCII}/` | A character in the ASCII character set | |
| `/\p{Any}/` | Any Unicode character (including unassigned characters) | |
| `/\p{Assigned}/` | An assigned character | |
| `/\p{L}/` | 'Letter' | |
| `/\p{Ll}/` | 'Letter: Lowercase' | |
| `/\p{Lm}/` | 'Letter: Mark' | |
| `/\p{Lo}/` | 'Letter: Other' | |
| `/\p{Lt}/` | 'Letter: Titlecase' | |
| `/\p{Lu}/` | 'Letter: Uppercase | |
| `/\p{Lo}/` | 'Letter: Other' | |
| `/\p{M}/` | 'Mark' | |
| `/\p{Mn}/` | 'Mark: Nonspacing' | |
| `/\p{Mc}/` | 'Mark: Spacing Combining' | |
| `/\p{Me}/` | 'Mark: Enclosing' | |
| `/\p{N}/` | 'Number' | |
| `/\p{Nd}/` | 'Number: Decimal Digit' | |
| `/\p{Nl}/` | 'Number: Letter' | |
| `/\p{No}/` | 'Number: Other' | |
| `/\p{P}/` | 'Punctuation' | |
| `/\p{Pc}/` | 'Punctuation: Connector' | |
| `/\p{Pd}/` | 'Punctuation: Dash' | |
| `/\p{Ps}/` | 'Punctuation: Open' | |
| `/\p{Pe}/` | 'Punctuation: Close' | |
| `/\p{Pi}/` | 'Punctuation: Initial Quote' | |
| `/\p{Pf}/` | 'Punctuation: Final Quote' | |
| `/\p{Po}/` | 'Punctuation: Other' | |
| `/\p{S}/` | 'Symbol' | |
| `/\p{Sm}/` | 'Symbol: Math' | |
| `/\p{Sc}/` | 'Symbol: Currency' | |
| `/\p{Sc}/` | 'Symbol: Currency' | |
| `/\p{Sk}/` | 'Symbol: Modifier' | |
| `/\p{So}/` | 'Symbol: Other' | |
| `/\p{Z}/` | 'Separator' | |
| `/\p{Zs}/` | 'Separator: Space' | |
| `/\p{Zl}/` | 'Separator: Line' | |
| `/\p{Zp}/` | 'Separator: Paragraph' | |
| `/\p{C}/` | 'Other' | |
| `/\p{Cc}/` | 'Other: Control' | |
| `/\p{Cf}/` | 'Other: Format' | |
| `/\p{Cn}/` | 'Other: Not Assigned' | |
| `/\p{Co}/` | 'Other: Private Use' | |
| `/\p{Cs}/` | 'Other: Surrogate' | |

```shell
Lastly, `\p{}` matches a character’s Unicode script. The following scripts are supported: Arabic, Armenian, Balinese, Bengali, Bopomofo, Braille, Buginese, Buhid, Canadian_Aboriginal, Carian, Cham, Cherokee, Common, Coptic, Cuneiform, Cypriot, Cyrillic, Deseret, Devanagari, Ethiopic, Georgian, Glagolitic, Gothic, Greek, Gujarati, Gurmukhi, Han, Hangul, Hanunoo, Hebrew, Hiragana, Inherited, Kannada, Katakana, Kayah_Li, Kharoshthi, Khmer, Lao, Latin, Lepcha, Limbu, Linear_B, Lycian, Lydian, Malayalam, Mongolian, Myanmar, New_Tai_Lue, Nko, Ogham, Ol_Chiki, Old_Italic, Old_Persian, Oriya, Osmanya, Phags_Pa, Phoenician, Rejang, Runic, Saurashtra, Shavian, Sinhala, Sundanese, Syloti_Nagri, Syriac, Tagalog, Tagbanwa, Tai_Le, Tamil, Telugu, Thaana, Thai, Tibetan, Tifinagh, Ugaritic, Vai, and Yi.
```

对于其它字符的支持:

```ruby
/\p{Arabic}/.match("\u06E9") #=> #<MatchData "\u06E9">
/\p{^Ll}/.match("A") #=> #<MatchData "A">
```

## 复用 Repetition
### 结构/量词
| 符号/量词 | English | 备注 |
|------|---------|------|
| * | Zero or more times | |
| + | One or more times | |
| ? | Zero or one times (optional) | |
| {n} | Exactly n times | |
| {n,} | n or more times | |
| {,m} | m or less times | |
| {n,m} | At least n and at most m times | |

### 模式
- 默认为贪婪型, 最多成功匹配
- 非贪婪/懒惰型, 最少*成功*匹配
    - 量词后面添加`?`
    - 涉及量词: ` * + {n,}`

```ruby
/<(.+)>/.match("<a><b>") # => #<MatchData "<a><b>" 1:"a><b">
/<(.+?)>/.match("<a><b>") # => #<MatchData "<a>" 1:"a">
/<(.+?)>/.match("<abc><b>") # => #<MatchData "<abc>" 1:"abc">
/<(.{1,}?)>/.match("<abc><b>") # => #<MatchData "<abc>" 1:"abc">
/<(.{1,})>/.match("<abc><b>") # => #<MatchData "<abc><b>" 1:"abc><b">
```

## 分组 Grouping
分组应该算是对上面东西的结构化.
从分组到归类,又是引用.

### 捕捉/获取 Capturing
主要涉及两种操作: 捕捉与引用

```ruby
/(?<vowel>[aeiou]).\k<vowel>.\k<vowel>/.match('ototomy')
    #=> #<MatchData "ototo" vowel:"o">
```

#### 捕捉
以`()`包含的一个Regular串是一个捕捉组, 从前到后依次为1,2,3,......

有名字的组,以如下模式进行包含

```ruby
(?<name>)
# or
(?'name')
```

#### 原子分组/捕捉
通过`(?>pat)`定义的分组是原子分组.

    在正则表达式的底层实现中, 通过原子分组, 可以取消匹配过程中的回溯.

```ruby
/"(.*)"/.match('"Quote"')     #=> #<MatchData "\"Quote\"" 1:"Quote">
/"(?>.*)"/.match('"Quote"') #=> nil
# 失败原因: .* 由于贪婪的原则, 匹配了", 后续正则式中的"无法再进行匹配, 导致出错.
# 上面的成功是产生的回溯.
```

#### 取消捕捉

```ruby
(?:regular)
```

#### 引用
直接可以使用`\1,\2,\k<name>`等进行引用

```ruby
\1
# with name
\k<name>
```

#### 有名变量化
如果正则表达式在`=~`*左侧*, 会按名字产生局部变量.

```ruby
dollars = 'abc'
/\$(?<dollars>\d+)\.(?<cents>\d+)/ =~ "$3.67" #=> 0
dollars #=> "3"
```
*注意局部变量会被修改*


```ruby
/[aeiou]\w{2}/.match("Caenorhabditis elegans") #=> #<MatchData "aen">
/([aeiou]\w){2}/.match("Caenorhabditis elegans")
    #=> #<MatchData "enor" 1:"or">
/I(n)ves(ti)ga\2ons/.match("Investigations")
    #=> #<MatchData "Investigations" 1:"n" 2:"ti">
/I(?:n)ves(ti)ga\1ons/.match("Investigations")
    #=> #<MatchData "Investigations" 1:"ti">
```

### 分组共用 子表达式共用 Subexpression Calls
通过`\g<name>`进行表达式的复用

```ruby
/\A(?<paren>\(\g<paren>*\))*\z/ .match '' # => #<MatchData "" paren:nil>

/\A(?<paren>\(\g<paren>*\))*\z/ .match '()' # => #<MatchData "()" paren:"()">

/\A(?<paren>\(\g<paren>*\))*\z/ .match '(())' # => #<MatchData "(())" paren:"(())">
# ^1 字符串开始
#      ^2 Regular(paren)实际内容是 ()
#           ^3 实际字符 (
#                 ^4 复用Regular(paren)
#                      ^7 多个Regular(paren)
#                       ^^8 实际字符 )
#                           ^10 字符串结束
```

#### 组内数据多选一 Alternation
通过`|`分割多个Regular

```ruby
/\w(and|or)\w/.match("Feliformia") #=> #<MatchData "form" 1:"or">
/\w(and|or)\w/.match("furandi")    #=> #<MatchData "randi" 1:"and">
/\w(and|or)\w/.match("dissemblance") #=> nil
```

## 锚点Anchors

用于后续正则表达式的*定位*, *不*参加匹配内容

| 符号 | English | 备注 |
|------|---------|------|
| `^` | Matches beginning of line | |
| `$` | Matches end of line | |
| `\A` | Matches beginning of string. | |
| `\Z` | Matches end of string. If string ends with a newline, it matches just before newline | |
| `\z` | Matches end of string | |
| `\G` | Matches point where last match finished | |
| `\b` | Matches word boundaries when outside brackets; backspace (0x08) when inside brackets | 单词分割符 |
| `\B` | Matches non-word boundaries | |
| `(?=pat)` | Positive lookahead assertion: ensures that the following characters match pat, but doesn't include those characters in the matched text | 零宽度正预测先行断言 |
| `(?!pat)` | Negative lookahead assertion: ensures that the following characters do not match pat, but doesn't include those characters in the matched text | 零宽度负预测先行断言 |
| `(?<=pat)` | Positive lookbehind assertion: ensures that the preceding characters match pat, but doesn't include those characters in the matched text | 零宽度正回顾后发断言 |
| `(?<!pat)` | Negative lookbehind assertion: ensures that the preceding characters do not match pat, but doesn't include those characters in the matched text | 零宽度负回顾后发断言 |

其中涉及断言机制, 具体名称可以再参见[正则表达式断言](http://richardustc.github.io/blog/2013/06/assertion-in-regular-expression/).

下面以零宽度正预测先行断言为例子,看看效果:

```ruby
/(\w+)(?=abc)/.match 'defabcdef' # => #<MatchData "def" 1:"def">
#      ^ 用于定位
#                        ^ 发现abc
#                     ^^^ (\w+) 的匹配, 位于指定位置前的数据
/(?=abc)(\w+)/.match 'defabcdef' # => #<MatchData "abcdef" 1:"abcdef">
```

## 整体配置
| 符号 | English | 备注 |
|------|---------|------|
| `/pat/i` | Ignore case | |
| `/pat/m` | Treat a newline as a character matched by . | |
| `/pat/x` | Ignore whitespace and comments in the pattern | 通过这个参数,可以在正则表达式中写注释了|
| `/pat/o` | Perform #{} interpolation only once | |

```ruby
float_pat = /\A
    [[:digit:]]+ # 1 or more digits before the decimal point
    (\.          # Decimal point
        [[:digit:]]+ # 1 or more digits after the decimal point
    )? # The decimal point and following digits are optional
\Z/x
float_pat.match('3.14') #=> #<MatchData "3.14" 1:".14">
```

## 编码 Encoding

| 符号 | English | 备注 |
|------|---------|------|
| `/pat/u` | UTF-8  | |
| `/pat/e` | EUC-JP  | |
| `/pat/s` | Windows-31J  | |
| `/pat/n` | ASCII-8BIT  | |

## Ruby 特色的全局变量
| 符号 | English | 备注 |
|------|---------|------|
| `$~` | is equivalent to ::last_match; | |
| `$&` | contains the complete matched text; | |
| $\`| contains string before match; | |
| `$'` | contains string after match; | |
| `$1, $2 and so` | on contain text matching first, second, etc capture group; | |
| `$+` | contains last capture group. | |

# 参考资料
- [Ruby Regular RDoc](http://www.ruby-doc.org/core-2.1.0/Regexp.html)
- [Ruby 正则表达式官方文档翻译参照](http://blog.chinaunix.net/uid-298861-id-3144205.html)
