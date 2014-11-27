---
title: Ruby 最佳实践读书笔记
tags: 
tagline: Ruby 基础技术
---

# 开发模式

* TDD
* BDD: spec http://www.infoq.com/cn/articles/Spec-Flow
* Mock,Stub

# 文本处理

## Line-Based File Processing with State Tracking
* 主要问题：分析有结构的数据文件，主要是分section
* 利用状态机原理进行分类处理,利用beginning/end markers for a section
* 利用栈结构进行状态保存（特别是nested sections）
* 保存整体数据状态Context
* 容错处理要完善，目前建议skip

        case section
        when [xxx,xxx]
           process
        when [xxx,xxx]
           process
        else
           process
        end

## 正则表达式
* 关键概念: 正则表达式的主要特性.http://qianjigui.iteye.com/blog/1390067
    * Anchors
    * Caution, quantifier

## File API
* Pathname Ruby 1.9
* FileUtils
* tempfile

### tempfile

```ruby

require 'tempfile'
a = Tempfile
a.close  (delete @ GC a)
a.close! (delete immediately)
```

## Advanced Line Processing
* Enumerator: foreach, each

        f=File.open
        f.each
        f.lineno

* Atomic Saves: Don't waste old file, and use tempfile then mv to it

# Function Programming
* http://qianjigui.iteye.com/blog/1997358
* 主要涉及基本的lamba操作,不过对其它特性支持并不好.


# API

## pp 相关库

```

#!/usr/bin/env ruby
#
# Pretty-Printer for Ruby Objects
require 'pp'
friends = [
    { first_name: 'Emily', last_name: 'Laskin'},
    { first_name: 'Nick',  last_name: 'Mauro'},
    { first_name: 'Mark',  last_name: 'Maxwell'}
]

me = {first_name: 'Gregory', last_name: 'Brown', friends: friends}

p me
puts '--------------'
pp me

class Person
    def initialize(fn,ln,friends)
        @fn,@ln,@frs = fn,ln,friends
    end

    # You can rewrite pretty_print
    def pretty_print(printer)
        printer.text <<-END
            Person <#{object_id}>:
                Name: #@fn #@ln
                Friends:
        END
        @frs.each do |f|
            printer.text <<-END
                    #{f[:first_name] } #{f[:last_name]}
            END
        end
    end
end

person = Person.new('Gregory','Brown',friends)
puts '========================='
pp person

=begin
Output:
{:first_name=>"Gregory", :last_name=>"Brown", :friends=>[{:first_name=>"Emily", :last_name=>"Laskin"}, {:first_name=>"Nick", :last_name=>"Mauro"}, {:first_name=>"Mark", :last_name=>"Maxwell"}]}
--------------
{:first_name=>"Gregory",
 :last_name=>"Brown",
 :friends=>
  [{:first_name=>"Emily", :last_name=>"Laskin"},
   {:first_name=>"Nick", :last_name=>"Mauro"},
   {:first_name=>"Mark", :last_name=>"Maxwell"}]}
=========================
            Person <540731910>:
                Name: Gregory Brown
                Friends:
                    Emily Laskin
                    Nick Mauro
                    Mark Maxwell
=end
```

## 注意直接使用open，返回值是StringIO

## Working with HTTP and FTP

```

require 'open-uri'

a = open('http://www.ruby-lang.org/en/LICENSE.txt')
pp a
=begin
<StringIO:0x002b1836406a90
 @base_uri=
  #<URI::HTTP:0x002b1836406f68 URL:http://www.ruby-lang.org/en/about/license.txt>,
 @meta=
  {"content-type"=>"text/plain",
   "last-modified"=>"Tue, 31 Dec 2013 12:28:20 GMT",
   "server"=>"thin 1.6.1 codename Death Proof",
   "content-length"=>"2504",
   "connection"=>"keep-alive"},
 @status=["200", "OK"]>
=end
# Here, you can use StringIO for saving data
```

## 时间处理，词法分析，HASH加密，数学处理，cvs,json,模板生成

```

#Working with Dates and Times(date)
puts 'date'
pp Date.today

#Lexical Parsing with Regular Expressions(strscan)
puts 'strscan'
require 'strscan'
s = StringScanner.new('This is an example string')
s.eos?               # -> false

p s.scan(/\w+/)      # -> "This"
p s.scan(/\w+/)      # -> nil
p s.scan(/\s+/)      # -> " "
p s.scan(/\s+/)      # -> nil
p s.scan(/\w+/)      # -> "is"
s.eos?               # -> false

p s.scan(/\s+/)      # -> " "
p s.scan(/\w+/)      # -> "an"
p s.scan(/\s+/)      # -> " "
p s.scan(/\w+/)      # -> "example"
p s.scan(/\s+/)      # -> " "
p s.scan(/\w+/)      # -> "string"
s.eos?               # -> true

p s.scan(/\s+/)      # -> nil
p s.scan(/\w+/)      # -> nil

#Cryptographic Hash Functions (digest)

puts 'digest'

require 'digest/md5'

pp Digest::MD5.hexdigest(File.binread(__FILE__))

require 'digest/sha2'
pp Digest::SHA256.hexdigest(File.binread(__FILE__))
```

## Mathematical Ruby Scripts(mathn)

```
puts 'mathn'
require 'mathn'
pp Math.sqrt(-1)
pp 1/2
```

## cvs,json,erb

