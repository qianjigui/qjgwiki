---
title: Java 数据类型间的强制转换
tags: Type
---

# 数据类型的强制转换

## byte 与 integer

```
//Java
byte b = (byte)0xC8;
int v1 = b;       // v1 is -56 (0xFFFFFFC8)
int v2 = b & 0xFF // v2 is 200 (0x000000C8)
```

```
//Golang
b := (byte)(0xC8)
var v1,v2 int
v1 = int(b)        //200
v2 = 0xFF & int(b) //200
```

核心原因:

1. 在语言定义时, java中byte `[-128,127]` , 在进行强制类型转换时会将高位与最近的低位相同后补齐
2. golang中byte `[0, 255]`

