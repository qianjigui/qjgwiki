---
title: "设计模式"
tags: undefine
---




#设计模式#

以下图片多来自[ 非关语言: 设计模式](http://www.riabook.cn/doc/designpattern/).

##Creational 模式##

物件的产生需要消耗系统资源，所以如何有效率的产生、管理与操作物件，一直都是值得讨论的课题， Creational 模式即与物件的建立相关，在这个分类下的模式给出了一些指导原则及设计的方向。

###Simple Factory 模式###

所有对象到生成都是通过普通工厂进行，消除和屏蔽大面积到New方法。

http://qjg-wiki.googlecode.com/files/SimpleFactoryDP.jpg

###Abstract Factory 模式###
http://qjg-wiki.googlecode.com/files/AbstractFactoryDP.jpg

###Builder 模式###
http://qjg-wiki.googlecode.com/files/BuilderDP.jpg

###Factory Method 模式###
http://qjg-wiki.googlecode.com/files/FactoryMethodDP.jpg

###Prototype 模式###
http://qjg-wiki.googlecode.com/files/ProtoTypeDP.jpg

###Singleton 模式###
{% highlight none %}
public class Singleton {
    private static Singleton instance = new Singleton();

    private Singleton() {
        // ....
    }

    public static Singleton getInstance() {
        return instance;
    }

    // 其它实作
}
{% endhighlight %}

{% highlight none %}
public class Singleton {
    private static Singleton instance = null;
    private Singleton(){}
    public static Singleton getInstance() {
        if (instance == null){
            synchronized(Singleton.class){
                if(instance == null) {
                     instance = new Singleton();
                }
            }
        }
        return instance;
    }
}
{% endhighlight %}

http://qjg-wiki.googlecode.com/files/SingletonDP.jpg

###Registry of Singleton 模式###

##Structural 模式##

如何设计物件之间的静态结构，如何完成物件之间的继承、实现与依赖关系，这关乎着系统设计出来是否健壮（robust）：像是易懂、易维护、易修改、耦合度低等等议题。
Structural 模式正如其名，其分类下的模式给出了在不同场合下所适用的各种物件关系结构。

###Default Adapter 模式###
http://www.riabook.cn/doc/designpattern/images/defaultAdapter-2.jpg

###Adapter 模式 - Object Adapter###
http://www.riabook.cn/doc/designpattern/images/adapter-2.jpg

###Adapter 模式 - Class Adapter###
http://www.riabook.cn/doc/designpattern/images/adapter-4.jpg

###Bridge 模式###
http://www.riabook.cn/doc/designpattern/images/bridge-4.jpg

###Composite 模式###
http://www.riabook.cn/doc/designpattern/images/composite-2.jpg

###Decorator 模式###
http://www.riabook.cn/doc/designpattern/images/decorator-3.jpg

###Facade 模式###
http://www.riabook.cn/doc/designpattern/images/facade-3.jpg

###Flyweight 模式###
http://www.riabook.cn/doc/designpattern/images/flyweight-1.jpg

###Proxy 模式（一）###
http://www.riabook.cn/doc/designpattern/images/proxy-2.jpg

http://www.riabook.cn/doc/designpattern/images/proxy-3.jpg
###Proxy 模式（二）###

##Behavioral 模式##

物件之间的合作行为构成了程式最终的行为，物件之间若有设计良好的行为互动，不仅使得程式执行时更有效率，更可以让物件的职责更为清晰、整个程式的动态结构（像是物件调度）更有弹性。

###Chain of Responsibility 模式###
http://www.riabook.cn/doc/designpattern/images/chainOfResponsibility-1.jpg

###Command 模式###
http://www.riabook.cn/doc/designpattern/images/command-2.jpg

###Interpreter 模式###
http://www.riabook.cn/doc/designpattern/images/interpreter-1.jpg

###Iterator 模式###
http://www.riabook.cn/doc/designpattern/images/iterator-2.jpg

###Mediator 模式###
http://www.riabook.cn/doc/designpattern/images/mediator-4.jpg

###Memento 模式###
http://www.riabook.cn/doc/designpattern/images/memento-1.jpg

###Observer 模式###
http://www.riabook.cn/doc/designpattern/images/observer-1.jpg

###State 模式###
http://www.riabook.cn/doc/designpattern/images/state-1.jpg

###Strategy 模式###
http://www.riabook.cn/doc/designpattern/images/strategy-2.jpg

###Template Method 模式###
http://www.riabook.cn/doc/designpattern/images/templateMethod-1.jpg

###Visitor 模式###
http://www.riabook.cn/doc/designpattern/images/visitor-1.jpg
