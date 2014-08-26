---
title: Java内部类的状态
tags: InnerClass
---

# 一个例子

```java
public class B{
    private int tc;
    public B(int c){
        tc = c;
    }
    public void a(){
        final int cc = (new C(5)).c;
        new Thread() {
            @Override
                public void run() {
                    System.out.println(String.valueOf(cc));
                }
        }.start();
    }
    public static void main(String[] args){
        (new B(23)).a();
        int i =(new D()).d;
    }

    class C{
        int c;
        public C(int i){
            c=i;
        }
    }

    static class D{
        int d;
    }
}
```

B$C: 

```java
Compiled from "B.java"
class B$C extends java.lang.Object{
int c;

final B this$0;

public B$C(B, int);
  Code:
   0:	aload_0
   1:	aload_1
   2:	putfield	#1; //Field this$0:LB;
   5:	aload_0
   6:	invokespecial	#2; //Method java/lang/Object."<init>":()V
   9:	aload_0
   10:	iload_2
   11:	putfield	#3; //Field c:I
   14:	return
}
```

B$D:

```java
Compiled from "B.java"
class B$D extends java.lang.Object{
int d;

B$D();
  Code:
   0:	aload_0
   1:	invokespecial	#1; //Method java/lang/Object."<init>":()V
   4:	return

}
```

# 静态内部类

不会添加对外部类的对象的引用.

# 普通内部类

与匿名内部类相同, 会在内部动态添加对父亲对象的引用.

# 匿名内部类
匿名内部类中, 通过编译器添加了成员变量保存final产生的数据.

```java
public class B{
    private int tc;
    public B(int c){
        tc = c;
    }
    public void a(){
        final int cc = tc;
        new Thread() {
            @Override
                public void run() {
                    System.out.println(String.valueOf(cc));
                }
        }.start();
    }
    public static void main(String[] args){
        (new B(23)).a();
    }
}
```

```java
Compiled from "B.java"
class B$1 extends java.lang.Thread{
final int val$cc;

final B this$0;

B$1(B, int);
  Code:
   0:   aload_0
   1:   aload_1
   2:   putfield        #1; //Field this$0:LB;
   5:   aload_0
   6:   iload_2
   7:   putfield        #2; //Field val$cc:I
   10:  aload_0
   11:  invokespecial   #3; //Method java/lang/Thread."<init>":()V
   14:  return

public void run();
  Code:
   0:   getstatic       #4; //Field java/lang/System.out:Ljava/io/PrintStream;
   3:   aload_0
   4:   getfield        #2; //Field val$cc:I
   7:   invokestatic    #5; //Method java/lang/String.valueOf:(I)Ljava/lang/String;
   10:  invokevirtual   #6; //Method java/io/PrintStream.println:(Ljava/lang/String;)V
   13:  return

}
```

