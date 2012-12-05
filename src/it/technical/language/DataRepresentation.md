---
title: "信息的表示和处理"
tags: ComputerSystem
---





#信息的表示和存储#

##数据存储##

###数据长短###
###寻址和直接顺序###
表示数据0x12345678,数据中0x12为数据最高位:
    * 大端:
|  地址 |  0x100|  0x101|  0x102|  0x103 | 
|------|------|------|------|------|
|  数据 |   12  |   34  |   56  |   78   | 

    * 小端:
|  地址 |  0x100|  0x101|  0x102|  0x103 | 
|------|------|------|------|------|
|  数据 |   78  |   56  |   34  |   12   | 

###C中的移位运算###
    * 左移(0xff<<8=0xff0)
    * 右移(0xff000000>>8):
        * 无符号数据(unsigned int/long): 逻辑右移(=0x 0f f0 00 00)
        * 符号数据(int/long): 算术(左端补最高有效位的拷贝)右移(=0x ff f0 00 00)

###整数表示###
在C语言中,主要有有符号数字和无符号数字标示。
现做如下规约:
    * B:binary(位表示)
    * U:unsigned(无符号表示)
    * T:有符号表示
    * 负数为二进制补码表示

数据组织:
| 位        |  w-1 |  w-2 |  ...... |  3 |  2 |  1 |  0 | 
|------|------|------|------|------|------|------|------|
| 数据(=0/1)|  x,,w-1,, |  x,,w-2,, |  ...... |  x,,3,, |  x,,2,, |  x,,1,, |  x,,0,, | 

结果:
    * B2U,,w,,(*x*) = sum(i:0..(w-1)){x,,i,,2^i^}
    * B2T,,w,,(*x*) = -x,,w-1,,2^w-1^ + sum(i:0..(w-2)){x,,i,,2^i^}
    * T2U,,w,,(*x*) , 原则是基本的位表示保持不变 = B2U,,w,,(T2B,,w,,(*x*)) = x,,w-1,,2^w^ + *x* = *x* + 2^w^ (x < 0), x (x>=0)
    * 对于含有符号和无符号的一个比较运算时，C会隐含地将有符号强制转换为无符号数。这种方法对于标准的算术运算来说并没有差异，但是对于像<>的关系运算存在问题:

|  0==0U |    1   | 
|------|------|
|  -1 is smaller than 0  |    1   | 
|  -1 is smaller than 0U |    *0* | 

    * 扩展一个数字的位:
        * 无符号数字转换为一个更大的数据类型，在头部补0--*零扩展*
        * 将一个二进制补码数字转换成更大的数据类型，采用*符号扩展*--头部添加最高有效位的值
    * 截断数字:
        * [x,,w-1,, , x,,w-2,, , ... , x,,2,, , x,,1,, , x,,0,,] ＝截断只剩K位=> [x,,k-1,, , x,,k-2,, , ... , x,,2,, , x,,1,, , x,,0,,]

## 浮点数据表示 ##
[浮点数表示和基本运算](http://www.cnblogs.com/FlyingBread/archive/2009/02/15/660206.html)

## 基于数据位的操作 ##
[Bit Twiddling Hacks](http://graphics.stanford.edu/~seander/bithacks.html) :
    * 基于最高位的符号数判断
{% highlight none %}
int v;
int sign;
sign = v >> (sizeof(int)*CHAR_BIT-1);//v>>31
{% endhighlight %}
    * 判断符号位是否相同
{% highlight none %}
int x,y;
bool f = ((x^y)<0);
{% endhighlight %}

###不需要跳转###
    * 语句处理绝对值
{% highlight none %} 
int v;
unsigned int r;
int const mask = v >> sizeof(int)*CHAR_BIT - 1;
r = (v+mask) ^ mask;
r = (v^mask) - mask;
{% endhighlight %}
    * 计算两个数的较大者/较小者
{% highlight none %} 
int x;
int y;
int r;
r = y^((x^y)&-(x<y));//min(x,y)
r = x^((x^y)&-(x<y));//max(x,y)

r = y + ((x - y) & ((x - y) >> (sizeof(int) * CHAR_BIT - 1))); // min(x, y)
r = x - ((x - y) & ((x - y) >> (sizeof(int) * CHAR_BIT - 1))); // max(x, y)
{% endhighlight %}
    * 判断一个数是否为2的幂
{% highlight none %} 
unsigned int v;
bool f;
f = (v&(v-1))==0;//v==0时有问题，0不是2的幂次
f = v && !(v & (v - 1));
{% endhighlight %}
    * 位标识处理
{% highlight none %} 
bool f;         // conditional flag
unsigned int m; // the bit mask
unsigned int w; // the word to modify:  if (f) w |= m; else w &= ~m;

w ^= (-f ^ w) & m;
{% endhighlight %}
    * 统计1-bit的个数
{% highlight none %} 
unsigned int v; // count the number of bits set in v
unsigned int c; // c accumulates the total bits set in v
for (c = 0; v; c++)
{
  v &= v - 1; // clear the least significant bit set
}
{% endhighlight %}
    * 数据交换
{% highlight none %} 
#define SWAP(a, b) (((a) ^= (b)), ((b) ^= (a)), ((a) ^= (b)))
{% endhighlight %}
