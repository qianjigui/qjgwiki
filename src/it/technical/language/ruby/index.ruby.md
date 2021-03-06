---
title: "Ruby 编程技巧"
tags: Index
---




#文件定位#
##文件名##
###自己在哪里###

```ruby
  File.expand_path(__FILE__) #所在文件的完整路径，不过如果被link后是不准确的
  File.dirname(filename)     #目录
  File.basename(filename)    #去掉目录的文件名
```

###ls###
函数

```ruby
  Dir[path_pattern] => 返回符合路径模式的所有文件以及文件夹
```


模式

```ruby
  src+'/**/**'+suffix #src目录下递归所有带有suffix后缀的文件以及文件夹
  src+'/**/'+dir+'/**' #src目录下递归所有处在名为dir文件夹下(如果最后一级是dir，前面没有dir，那么是不被匹配的)的文件以及文件夹
```


##ERB##

```ruby
 require 'erb'
 template = File.read(tmp_path)
 template = ERB.new(template)
 File.open(file_path,'w')do |nf|
   nf.puts template.result(binding)
 end
```


# 其它参考
- [Ruby常用265技巧](<%=(ruby265methods)l%>)
- [Ruby技术讨论](http://blog.chinaunix.net/topic/ruby/)
- [Ruby 正则表达式](<%=(Regular)l%>)
