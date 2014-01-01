---
title: "散列表"
tags: Datastructure
---





#散列表#
##数据组织方法##
[算法导论散列表笔记](http://blog.chinaunix.net/uid-26822401-id-3169705.html)

    * 直接寻址法:避免碰撞的方法:链接法
    * 全域散列
        * 开放寻址法(将数据存放在线性结构上,譬如数组.在合适的时侯进行扩容):
            * 一次探测(线性探测): h(k, i) = (h'(k) + i) mod m, i = 0, 1, ..., m-1
            * 二次探测: h(k, i) = (h'(k) + c1*i + c2*i^2) mod m
            * 双重探测: h(k, i) = (h1(k) + i*h2(k)) mod m

## Hash函数 ##

### 字符串 ###

[各种字符串hash函数比较](http://www.byvoid.com/blog/string-hash-compare/)

####BKDRH####

```c
//BKDR Hash Function
unsigned int BKDRHash(char *str)
{
    unsigned int seed = 131; // 31 131 1313 13131 131313 etc..
    unsigned int hash = 0;

    while (*str){
        hash = hash * seed + (*str++);
    }

    return (hash & 0x7FFFFFFF);
}
```
