---
title: C语言
---
#C Programming language#

##Makefile##
Makefile 详细指南 [http://blog.csdn.net/liang13664759/archive/2007/09/04/1771246.aspx]

利用make工具，将构建自动化。进而又先后出现了Ant、Maven以及Rake，这些工具不但是将构建自动化，并且进一步将任务管理自动化。

总结的思维导图: ItTechnicalMake

##Mod 取余##
余数的定义:
  当被除数不够整除时余下的数。当都是正整数时:

除法实际可转化为减数，不够减时剩下的就是余数。

例如:
  12%5
  12-5-5
  2

当存在负数时: x%y
{{{
   i. 当异号时：
                 if |x|>|y|
                    result: x+y
                 else
                    result: x
             例：
                -6% 5等于－1
                 6%-5等于 1
                 5%-6等于 5
                -5% 6等于 -5
   ii. 当同号时：
                if |x|>|y|
                    result: x-y
                 else
                    result: x
             例：
               -1%-5等于-1
                -6%-5等于-1
                -4%-5等于-4
                -5%-6等于-5
}}}

##struct##
[http://stackoverflow.com/questions/612328/difference-between-struct-and-typedef-struct-in-c]

##Macro##
宏的概念在C中运用最为普遍，普通的替换和联接就不再多说。
关键是字符中的替换：
{{{

//字符串连接
#define DEFINE_EQ(_name)\
    equal##_name##To

...
DEFINE_EQ(Integer)   // => equalIntegerTo
...

//字符串化
#define PRINT_FUN(_name)\
    printf("%s: %d\n", #_name, _name)

...
PRINT_FUN(var) //printf("%s: %d\n", "var", var)
...
}}}

#C++ Programming language#
##命名空间##
{{{
  // one.h
  namespace one
  {
    char func(char);
    class String { ... };
  }
}}}

一个不错的总结网站 [http://hi.baidu.com/%C5%E1%F6%CE0227/blog/item/26578b1295cf55876438db64.html]

##运算符重载与模板类##
需要合理考虑:
  * inline
  * 参数&化
  * 抽象代码与实现
  * const
  * Complex实例 [http://www.aoc.nrao.edu/php/tjuerges/ALMA/STL/html-3.4.6/complex-source.html]

##函数参数和返回值##
###传递方式###
值传递(指针传递也是一种值传递)

引用传递: 值传递的外表、指针传递的作用。

指针与引用:
  * 都是地址的概念: 指针指向一块内存，它的内容是所指内存的地址；而引用则是某块内存的别名。
  * 指针是一个实体，而引用仅是个别名；
  * 引用只能在定义时被初始化一次，之后不可变；指针可变；引用“从一而终”，指针可以“见异思迁”；
  * 引用没有const，指针有const，const 的指针不可变；（具体指没有int& const a这种形式，而const int& a是有的，前者指引用本身即别名不可以改变，这是当然的，所以不需要这种形式，后者指引用所指的值不可以改变 ）
  * 引用不能为空，指针可以为空；
  * "sizeof 引用" 得到的是所指向的变量( 对象) 的大小，而"sizeof 指针"得到的是指针本身的大小；
  * 指针和引用的自增(++) 运算意义不一样；
  * 引用是类型安全的，而指针不是(引用比指针多了类型检查)

####引用作为返回值####
必须遵守以下规则:
  # 不能返回局部变量的引用。主要原因是局部变量会在函数返回后被销毁，因此被返回的引用就成为了"无所指"的引用，程序会进入未知状态。
  # 不能返回函数内部new分配的内存的引用。虽然不存在局部变量的被动销毁问题，可对于这种情况（返回函数内部new分配内存的引用），又面临其它尴尬局面。例如，被函数返回的引用只是作为一个临时变量出现，而没有被赋予一个实际的变量，那么这个引用所指向的空间（由new分配）就无法释放，造成memory leak。
  # 可以返回类成员的引用，但最好是const。主要原因是当对象的属性是与某种业务规则（business rule）相关联的时候，其赋值常常与某些其它属性或者对象的状态有关，因此有必要将赋值操作封装在一个业务规则当中。如果其它对象可以获得该属性的非常量引用（或指针），那么对该属性的单纯赋值就会破坏业务规则的完整性。

###不定长参数###
关键思路: 利用堆指针来实现引用和调整。
[http://www.dutor.net/index.php/2011/08/variadic/ 关于变参]

##命名规则##
C++ 命名规则 [http://blog.csdn.net/huliang82/article/details/3870153]

##编译器##
###GCC###
  * templates may not be ‘virtual’, *typename* change to *class*
  * 模板的定义与实现需要写在同一个头文件中
  * 模板中使用迭代:
{{{
typename std::list<_Tp>::iterator terrain_it;//define a iterator
}}}
  * 临时变量无法被转换成引用
{{{
void fun(string & x){...}
...
fun(string("132"));//Error
...
string s("132");
fun(s);//Right
...
}}}
  * 非常严厉，连const匹配都要检查
  * expected constructor, destructor, or type conversion before 需要在返回类型前加*typename* [http://www.cnblogs.com/edwardlost/archive/2011/04/25/2027656.html]:
    只要是符合类型，特别是利用typedef声明时，如果提示类型错误，就需要添加typename显示指明为类中声明的类型。
  * 模板类的派生类中必须显式调用基类成员 [http://blog.sina.com.cn/s/blog_4f183d960100j7er.html]

#C与C++的整体感觉#
语言的原生态或者说原始性很强，给程序员提供了一个强大的基础实现平台，特别适合高级程序员更为专业的控制与实现。
指针、模板、复杂的参数规范其实是想让编译器给我们提供更好地更为实用的帮助与辅导。

与Ruby这种解释型语言不通，编译型语言通过强大的后期处理提高了效能，但是这也给程序员一个更为抽象地理解编程与接口制造了障碍。
我感觉Ruby的一个特性就是一致性，连+-*/这种原子化操作都是抽象在方法接口这一层。

##Class##
感觉一个类就是一个提供了小范围*全局变量*的模块控制单元。

##内存管理与指针##
什么时候需要使用引用、指针，何时创建一个内存区域，如何保持一致性？
从现在的编程感觉来说，我认为需要*同一层次(函数体、循环体)*创建或者销毁数据。
如果下层调用需要，通过指针传递进去。

##编程注意事项##
  * 数据越界，看看template complex abs() 实现

