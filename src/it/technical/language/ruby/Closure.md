---
title: Ruby 中的闭包
tags: Closure
---

http://rubyer.me/blog/917/

Ruby:

* block = Proc
* Proc = code part 代码片断, 与引用部分属于同一个上下文
* lambda = noname Method
* Method

```ruby
def a
    sum = 0
    return lambda do |x|
        sum += x
    end
end

pos = a
neg = a

(1.upto(5)).each do |i|
    puts '%d %d' % [pos.call(i),neg.call(-2*i)]
end

#  1 -2
#  3 -6
#  6 -12
#  10 -20
#  15 -30
```
