---
title: Ruby 元编程
tags: Meta
tagline: 元编程技术让代码写代码
---

Ruby元编程 【意】Paolo Perrotta

# Meta Programming

## 对象模型
* Ruby的class关键字更像是一个作用域操作符而不是类型声明语句。它的确可以创建一个还不存在的类，不过也可以把这看成是一种副作用。对于class关键字，其核心任务是把你带到类的上下文中，让你可以在其中定义方法。
* 与Java这样的静态语言不一样，Ruby中对象的类和它的实例变量没有关系，当给实例变量赋值时，它们就生成了。因此，对同一个类，你可以创建具有不同实例变量的对象。
* 类自身也是对象
* 所有常量像文件系统一样组织成树形结构。其中模块（还有类）像目录，而常量则像文件。跟文件系统一样，只要不在同一个目录下，不同文件的文件名可以相同，甚至可以像文件系统一样通过路径方式来引用一个常量。

### 对象系统
* 什么是对象？对象无非就是一组实例变量外加一个指向其类的引用。对象的方法并不存在于对象本身，而是存在于对象的类中。在类中，这些方法被称为类的实例方法。
* 什么是类？类无非就是一个对象（Class类的一个实例）外加一组实例方法和一个对其超类的引用。Class类是Module类的子类，因此一个类也是一个模块。
* 跟任何其他对象一样，类有自己的方法（比如new()方法），这些是Class类的实例方法。跟其他对象一样，类必须通过引用进行访问。你已经使用常量引用过它们：这就是类的名字。
* 为了查找一个方法，Ruby首先在接收者的类中查找，然后一层层地在祖先链中查找，直到找到这个方法为止。
* 当你在一个类（甚至可以是另外一个模块）中包含（include）一个模块时，Ruby耍了些小花招。Ruby创建了一个封装该模块的匿名类，并把这个匿名类插入到祖先链中，其在链中的位置正好包含在它的类上方
* 这些“封装（wrapper）”类叫做包含类（include class），有时也叫做代理类（proxy class）。包含类是Ruby的一个秘密，superclass()方法会假装它们根本不存在，而且你也一般不能通过正常的Ruby代码访问它们。
* 当开始运行Ruby程序时，Ruby解释器会创建一个名为main的对象作为当前对象。这个对象有时被称为顶级上下文（top level context），这个名字的由来是因为这时处在调用堆栈的顶层：这时要么还没有调用任何方法，要么调用的所有方法都已经返回了。
* 私有方法服从一个简单的规则：不能明确指定一个接收者来调用一个私有方法
* 私有方法是由两条规则一起控制的：第一条，如果调用方法的接收者不是你自己，则必须明确指明一个接收者；第二条，私有方法只能被隐含接收者调用。把这两条规则糅合在一起，你会发现只能在自身中调用一个私有方法。你可以把这个糅合后的规则称为“私有规则”。

### 对象模型小结
* 对象由一组实例变量和一个类的引用组成。
* 对象的方法存在于对象所属的类中（从类的角度看，它们叫做实例方法）。
* 类本身是Class类的对象。类的名字不过是一个常量而已。
* Class类是Module的子类。一个模块基本上是由一组方法组成的包。类除了具有模块的特性之外，还可以被实例化（通过new()方法）及被组织为层次结构（通过它的superclass()方法）。
* 常量像文件系统一样，是按照树形结构组织的。其中模块和类的名字扮演目录的角色，其他普通的常量则扮演文件的角色。
* 每个类都有一个祖先链，这个链从自己所属的类开始，向上直到BasicObject类结束。
* 当调用一个方法时，Ruby首先向右一步来到接收者所属的类，然后一直向上查找祖先链，直到找到该方法，或者到达链的顶端为止。
* 每当类包含一个模块时，该模块会被插入到祖先链中，位置在该类的正上方。
* 当调用一个方法时，接收者会扮演self的角色。
* 当定义一个模块（或者类）时，该模块扮演self的角色。
* 实例变量永远都被认定为self的实例变量。
* 任何没有明确指定接收者的方法调用，都当成是调用self的方法。
* 注: ruby的统一化思想，self很关键。理清楚上下文，可以更好的使用。

### 2.5 关于method_missing()方法的更多内容
1. 第一种方法依赖于动态方法和动态派发：

```
#methods/computer/more_dynamic.rb

class Computer
    def initialize(computer_id, data_source)
        @id = computer_id
        @data_source = data_source
        data_source.methods.grep(/^get_(.*)_info$/) { Computer.define_component $1 }
    end

    def self.define_component(name)
        define_method(name) {
            info = @data_source.send "get_#{name}_info", @id
            price = @data_source.send "get_#{name}_price", @id
            result = "#{name.capitalize}: #{info} ($#{price})"
            return " * #{result}" if price >= 100
            result
        }
    end
end
```

2. 第二种方法使用了动态代理及白板技术：

```ruby
# methods/computer/final.rb

class Computer
    instance_methods.each do |m|
        undef_method m unless m.to_s =~ /^__|method_missing|respond_to?/
    end
    def initialize(computer_id, data_source)
        @id = computer_id
        @data_source = data_source
    end

    def method_missing(name, *args)
        super if !respond_to?(name)
        info = @data_source.send("get_#{name}_info", args[0])
        price = @data_source.send("get_#{name}_price", args[0])
        result = "#{name.to_s.capitalize}: #{info} ($#{price})"
        return " * #{result}" if price >= 100
        result
    end
    
    def respond_to?(method)
        @data_source.respond_to?("get_#{method}_info") || super
    end
end

```

3. `ensure`语句都会调用`resource`的`dispose()`方法来释放它。
    * 注: 主要再学习下整个异常体系，何时是捕获。该处表现的是finally效果

### 作用域门
准确地说，程序会在三个地方关闭前一个作用域，同时打开一个新的作用域：
* 类定义。
* 模块定义。
* 方法。

只要程序进入类或模块及方法的定义，就会发生作用域切换。这三个边界分别用class、module和def关键字作为标志。每一个关键字都充当了一个作用域门（Scope Gate）。

每个Ruby作用域包含一组绑定，并且不同的作用域之间被作用域门分隔开来：class、module和def。如果要让一两个绑定穿越作用域门，那么可以用方法调用来代替作用域门：用一个闭包获取当前的绑定，并把这个闭包传递给该方法。你可以使用Class.new()方法代替class，使用Module.new代替module，以及使用Module#define_method()代替def。这就形成了一个扁平作用域，它是闭包中的一个基本概念。如果在一个扁平作用域中定义了多个方法，则这些方法可以用一个作用域门进行保护，并共享绑定，这种技术称为共享作用域。

### 代码片段
* 可调用对象是可以执行的代码片段，而且它们有自己的作用域。可调用对象可以有以下几种方式。
* 块（虽然它们不是真正的“对象”，但是它们是“可调用的”）：在定义它们的作用域中执行。
* proc：Proc类的对象，跟块一样，它们也在定义自身的作用域中执行。
* lambda：也是Proc类的对象，但是它跟普通的proc有细微的区别。它跟块和proc一样都是闭包，因此也在定义自身的作用域中执行。
* 方法：绑定于对象，在所绑定对象的作用域中执行。它们也可以与这个作用域解除绑定，再重新绑定到另一个对象的作用域上。
* 不同种类的可调用对象有细微的区别。在方法和lambda中，return语句从可调用对象中返回。在块和proc中，return语句从定义可调用对象的原始上下文中返回。另外，不同的可调用对象对传入参数数目不符有不同的反应。其中方法处理方式最严格，lambda同样严格（它与方法相比，在某些极端情况下略为宽松），而proc和块则要宽松一些。
* 尽管有这些区别，还是可以将一种可调用对象转换为另外一种可调用对象的，实现这样功能的方法包括Proc.new()方法、Method#to_proc()方法和&操作符。

## 4.1 类定义揭秘
* 如果希望在类中存储一个变量，那么除了类实例变量，还可以使用以@@开头的类变量（class variable）：

        class C
            @@v = 1
        end

* 类变量与类实例变量不同，它们可以被子类或类的实例所使用（在这个意义上，它们更像是Java的静态成员。）。

        class D < C
            def my_method; @@v; end
        end
        D.new.my_method # 1

* 不幸的是，类变量有一个很不好的怪癖。下面是一个例子：

        @@v = 1
        class MyClass
            @@v = 2
        end
        @@v # 2

* 得到这样的结果是因为类变量并不真正属于类 ——它们属于类体系结构。由于@@v定义于main的上下文，它属于main的类Object……所以也属于Object的所有后代。MyClass继承自Object，因此它也共享了这个类变量。
    * 从技术上讲，尽管这种行为可以理解，但它还是很容易把你绊倒。因为可能会遇到上面所示的意外事件，现在绝大多数Ruby主义者都避免使用类变量，而尽量使用类实例变量。

### instance_eval

`instance_eval()`方法的标准含义是：“我想修改self。”

### eigenclass
如果把eigenclass、普通类和模块放到一起，Ruby对象模型可以总结为7条规则：

1. 只有一种对象——要么是普通对象，要么是模块。
2. 只有一种模块——可以是普通模块、类、eigenclass或代理类。
3. 只有一个方法，它存在于一种模块中——通常是类中。
4. 每个对象（包括类）都有自己的“真正的类”——要么是普通类，要么是eigenclass。
5. 除了BasicObject类（在Ruby 1.8中是Object类）无超类外，每个类有且只有一个超类。这意味着从任何类只有一条向上直到BasicObject的祖先链。
6. 一个对象的eigenclass的超类是这个对象的类；一个类的eigenclass的超类是这个类的超类的eigenclass（试着把这个绕口令重复三遍，加快速度！然后回头看看图4.5，你会发现这句话是有道理的。）。
7. 当调用一个方法，Ruby先向“右”迈一步进入接收者真正的类，然后向“上”进入祖先链。这就是Ruby查找方法的全部内容。
 
### 4.5 小测验：模块的麻烦
当类包含模块时，它获得的是该模块的实例方法——而不是类方法。类方法存在于模块的eigenclass中，依然无法触碰。

### 5.7 钩子方法
这种技术是前面两种法术——类扩展和钩子方法——的结合。可以把这种技术称为类扩展混入（Class Extension Mixin）。
现在应该回顾使用这种法术的步骤：
1. 定义一个模块，姑且叫做MyMixin。
2. 在MyMixin中定义一个内部模块（通常把它叫做ClassMethods），并给它定义一些方法。这些方法最终会成为类方法。
3. 覆写MyMixin#included()方法来用ClassMethods扩展包含者（使用extend()方法）。

### 5.8 小测验：校验过的属性（第五步）

```

module CheckedAttributes
    def self.included(base)
        base.extend ClassMethods
    end

    module ClassMethods
        def attr_checked(attribute, &validation)
            define_method "#{attribute}=" do |value|
                raise 'Invalid attribute' unless validation.call(value)
                instance_variable_set("@#{attribute}", value)
            end

            define_method attribute do
                instance_variable_get "@#{attribute}"
            end
        end
    end
end
```

# 第6章 尾声
大师烦了。“虽然你够聪明，小子，”大师说道，“但是你有足够的智慧去忘掉所学的东西么？根本没有什么元编程，只有编程而已。走吧，让我继续平静地沉思。”
通过增加代码的内部复杂性，库就可以更容易为客户端所使用。

# Ruby法术
## 数组参数 Argument Array
把一组参数压入到一个数组中。

```

def my_method(*args)
    args.map{|arg|arg.reverse}
end
my_method('abc','xyz','123')#=>["cba","zyx","321"]
```

## 环绕别名
Around Alias
从一个重新定义的方法中调用原始的、被重命名的版本。

```

class String
    alias :old_reverse:reverse
    def reverse
        "x#{old_reverse}x"
    end
end
"abc".reverse#=>"xcbax"
```

## 白板
Blank Slate
移除一个对象中的所有方法，以便把它们转换成幽灵方法。

```

class C
    def method_missing(name,*args)
        "a Ghost Method"
    end
end
obj=C.new
obj.to_s#=>"#<C:0x357258>"
class C
    instance_methods.each do|m|
        undef_methodm unless m.to_s=~/method_missing|respond_to?|^/
    end
end
obj.to_s#=>"a Ghost Method"
```

## 类扩展
Class Extension
通过向类的eigenclass中混入模块来定义类方法（是对象扩展的一个特例）。

```

class C;end
module M
    def my_method
        'aclass method'
    end
end
class<<C
    include M
end
C.my_method#=>"a class method"
```

## 类扩展混入
Class Extension Mixin
使一个模块可以通过钩子方法扩展它的包含者。

```

module M
    def self.included(base)
        base.extend(ClassMethods)
    end
    module ClassMethods
        def my_method
            'a class method'
        end
    end
end
class C
    include M
end
C.my_method#=>"a class method"
```

## 类实例变量
Class Instance Variable
在一个Class对象的实例变量中存储类级别的状态。

```

class C
    @my_class_instance_variable="some value"
    def self.class_attribute
        @my_class_instance_variable
    end
end
C.class_attribute#=>"some value"
```

## 类宏
Class Macro
在类定义中使用一个类方法。

```

class C;end
class<<C
    def my_macro(arg)
        "my_macro(#{arg}) called"
    end
end
class C
    my_macro:x#=>"my_macro(x) called"
end
```

## 洁净室
Clean Room
使用对象作为执行块的上下文环境。

```

class CleanRoom
    def a_useful_method(x);x*2;end
end
CleanRoom.new.instance_eval{a_useful_method(3)} #=>6
```

## 代码处理器
Code Processor
处理从外部获得的字符串代码。

```

File.readlines("a_file_containing_lines_of_ruby.txt").each do|line|
    puts"#{line.chomp}==>#{eval(line)}"
end
#>>1+1==>2
#>>3*2==>6
#>>Math.log10(100)==>2.0
```

## 上下文探针
Context Probe
执行块来获取对象上下文中的信息。

```

class C
    def initialize
        @x="a private instance variable"
    end
end
obj=C.new
obj.instance_eval{@x}#=>"a private instance variable"
```

## 延迟执行
Deferred Evaluation
在proc或lambda中存储一段代码及其上下文，用于以后执行。

```

class C
    def store(&block)
        @my_code_capsule=block
    end
    def execute
        @my_code_capsule.call
    end
end
obj=C.new
obj.store{$X=1}
$X=0
obj.execute
$X#=>1
```

## 动态派发
Dynamic Dispatch
在运行时决定调用哪个方法。

```

method_to_call=:reverse
obj="abc"
obj.send(method_to_call)#=>"cba"
```

## 动态方法
Dynamic Method
在运行时才决定如何定义一个方法。

```

class C
end
C.class_eval do
    define_method:my_method do
        "a dynamic method"
    end
end
obj=C.new
obj.my_method#=>"a dynamic method"
```

## 动态代理
Dynamic Proxy
把不能对应某个方法名的消息转发给另外一个对象。

```

class MyDynamicProxy
    def initialize(target)
        @target=target
    end
    def method missing(name,*args,&block)
        "result:#{@target.send(name,*args,&block)}"
    end
end
obj=MyDynamicProxy.new("a string")
obj.reverse#=>"result: gnirts a"
```

## 扁平作用域
Flat Scope
使用闭包在两个作用域之间共享变量。

```

class C
    def an_attribute
        @attr
    end
end
obj=C.new
a_variable=100
#flatscope:
obj.instance_eval do
    @attr=a_variable
end
obj.an_attribute#=>100
```

## 幽灵方法
Ghost Method
响应一个没有关联方法的消息。

```

class C
    def method_missing(name,*args)
        name.to_s.reverse
    end
end
obj=C.new
obj.my_ghost_method #=>"dohtem_tsohg_ym"
```

## 钩子方法
Hook Method
通过覆写某个特殊方法来截获对象模型事件。

```

$INHERITORS=[]
class C
    def self.inherited(subclass)
        $INHERITORS<<subclass
    end
end
class D<C
end
class E<C
end
class F<E
end
$INHERITORS #=>[D,E,F]
```

## 内核方法
Kernel Method
在Kernel模块中定义一个方法，使之对所有对象都可用。

```

module Kernel
    def a_method
        "a kernel method"
    end
end
a_method#=>"a kernel method"
```

## 惰性实例变量
Lazy Instance Variable
当第一次访问一个实例变量时才对之进行初始化。

```

class C
    def attribute
        @attribute=@attribute||"some value"
    end
end
obj=C.new
obj.attribute#=>"some value"
```

## 拟态方法
Mimic Method
把一个方法伪装成另外一种语言构件。

```

def BaseClass(name)
    name=="string" ? String : Object
end
class C<BaseClass "string" #一个看起来像类的方法
    attr_accessor :an_attribute #一个看起来像关键字的方法
end
obj=C.new
obj.an_attribute=1 #一个看起来像属性的方法
```

## 猴子打补丁
Monkeypatch
修改已有类的特性。

```

"abc".reverse #=>"cba"
class String
    def reverse
        "override"
    end
end
"abc".reverse #=>"override"
```

## 有名参数
Named Arguments
把方法参数收集到一个哈希表中，以便通过名字访问。

```

def my_method(args)
    args[:arg2]
end
my_method(:arg1=>"A",:arg2=>"B",:arg3=>"C") #=>"B"
```

## 命名空间
Namespace
在一个模块中定义常量，以防止命名冲突。

```

module MyNamespace
    class Array
        def to_s
            "myclass"
        end
    end
end
Array.new #=>[]
MyNamespace::Array.new#=>my class
```

## 空指针保护
Nil Guard
用“或”操作符覆写一个空引用。

```
x=nil
y=x ||"a value" # =>"a value"
```

## 对象扩展
Object Extension
通过给一个对象的eigenclass混入模块来定义单件方法。

```
obj=Object.new
module M
    def my_method
        'a singleton method'
    end
end
class<<obj
    include M
end
obj.my_method#=>"a singleton method"
```

## 打开类
Open Class
修改已有的类。

```
class String
    def my_string_method
        "my method"
    end
end
"abc".my_string_method#=>"my method"
```

## 模式派发
Pattern Dispatch
根据名字来选择需要调用的方法。

```

$x=0
class C
    def my_first_method
        $x +=1
    end
    def my_second_method
        $x +=2
    end
end
obj=C.new
obj.methods.each do |m|
    obj.send(m) if m.to_s=~/^my_/
end
$x # => 3
```

## 沙盒
Sandbox
在一个安全的环境中执行未授信的代码。

```

def sandbox(&code)
    proc {
        $SAFE = 2
        yield
    }.call
end
begin
    sandbox{File.delete 'a_file'}
rescue Exception=>ex
    ex #=>#<SecurityError:Insecure operation 'delete' at level 2>
end
```

## 作用域门
Scope Gate
用class、module或def关键字来隔离作用域。

```

a=1
defined? a #=>"local-variable"
module MyModule
    b = 1
    defined? a#=>nil
    defined? b#=>"local-variable"
end
defined? a #=>"local-variable"
defined? b #=>nil
```

## Self Yield
把self传给当前块。

```

class Person
    attr_accessor :name, :surname
    def initialize
        yield self
    end
end
joe = Person.new do |p|
    p.name = 'Joe'
    p.surname = 'Smith'
end
```

## 共享作用域
Shared Scope
在同一个扁平作用域的多个上下文中共享变量。

```

lambda {
    shared = 10
    self.class.class_eval do
        define_method: counter do
            shared
        end
        define_method :down do
            shared -= 1
        end
    end
}.call
Counter #=>10
3.times {down}
Counter #=>7
```

## 单件方法
Singleton Method
在一个对象上定义一个方法。

```

obj = "abc"
class << obj
    def my_singleton_method
        "x"
    end
end
obj.my_singleton_method # => "x"
```

## 代码字符串
String of Code
执行一段表示Ruby代码的字符串。

```

my_string_of_code="1+1"
eval(my_string_of_code)#=>2
```

## 符号到Proc
Symbol To Proc
把一个符号转换为调用单个方法的代码块。

```

[1, 2, 3, 4].map(&:even?) # => [false, true, false, true]
```

