---
title: "Java 标注"
tags: Annotation
---

#Java Annotations#

##Class Annotations##

```java
@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.TYPE)
public @interface MyAnnotation {
    public String name();
    public String value();
}

```



```java
@MyAnnotation(name="someName",  value = "Hello World")
public class TheClass {
}

Class aClass = TheClass.class;
Annotation[] annotations = aClass.getAnnotations();

for(Annotation annotation : annotations){
    if(annotation instanceof MyAnnotation){
        MyAnnotation myAnnotation = (MyAnnotation) annotation;
        System.out.println("name: " + myAnnotation.name());
        System.out.println("value: " + myAnnotation.value());
    }
}

Class aClass = TheClass.class;
Annotation annotation = aClass.getAnnotation(MyAnnotation.class);

if(annotation instanceof MyAnnotation){
    MyAnnotation myAnnotation = (MyAnnotation) annotation;
    System.out.println("name: " + myAnnotation.name());
    System.out.println("value: " + myAnnotation.value());
}

```

##Method Annotations##

```java
public class TheClass {
  @MyAnnotation(name="someName",  value = "Hello World")
  public void doSomething(){}
}

Method method = ... //obtain method object
Annotation[] annotations = method.getDeclaredAnnotations();

for(Annotation annotation : annotations){
    if(annotation instanceof MyAnnotation){
        MyAnnotation myAnnotation = (MyAnnotation) annotation;
        System.out.println("name: " + myAnnotation.name());
        System.out.println("value: " + myAnnotation.value());
    }
}

Method method = ... // obtain method object
Annotation annotation = method.getAnnotation(MyAnnotation.class);

if(annotation instanceof MyAnnotation){
    MyAnnotation myAnnotation = (MyAnnotation) annotation;
    System.out.println("name: " + myAnnotation.name());
    System.out.println("value: " + myAnnotation.value());
}

```

##Paramenter Annotations##

```java
public class TheClass {
  public static void doSomethingElse(
        @MyAnnotation(name="aName", value="aValue") String parameter){
  }
}
Method method = ... //obtain method object
Annotation[][] parameterAnnotations = method.getParameterAnnotations();
Class[] parameterTypes = method.getParameterTypes();

int i=0;
for(Annotation[] annotations : parameterAnnotations){
  Class parameterType = parameterTypes[i++];

  for(Annotation annotation : annotations){
    if(annotation instanceof MyAnnotation){
        MyAnnotation myAnnotation = (MyAnnotation) annotation;
        System.out.println("param: " + parameterType.getName());
        System.out.println("name : " + myAnnotation.name());
        System.out.println("value: " + myAnnotation.value());
    }
  }
}

```

##Field Annotations##

```java
public class TheClass {

  @MyAnnotation(name="someName",  value = "Hello World")
  public String myField = null;
}

Field field = ... //obtain field object
Annotation[] annotations = field.getDeclaredAnnotations();

for(Annotation annotation : annotations){
    if(annotation instanceof MyAnnotation){
        MyAnnotation myAnnotation = (MyAnnotation) annotation;
        System.out.println("name: " + myAnnotation.name());
        System.out.println("value: " + myAnnotation.value());
    }
}

Field field = ... // obtain method object
Annotation annotation = field.getAnnotation(MyAnnotation.class);

if(annotation instanceof MyAnnotation){
    MyAnnotation myAnnotation = (MyAnnotation) annotation;
    System.out.println("name: " + myAnnotation.name());
    System.out.println("value: " + myAnnotation.value());
}

```


##User defined Annotation##


```java
//Twizzle.java
package demo;

/*
 * Annotation提供了一条与程序元素关联任何信息或者任何元数据（metadata）的途径。
 * 从某些方面看，annotation就像修饰符一样被使用，并应用于包、类型、构造方法、方法、成员变量、参数、本地变量的声明中。
 * 这些信息被存储在annotation的“name=value”结构对中。annotation类型是一种接口，能够通过java反射API的方式提供对其信息的访问。
 * 
 * 
 * 
 */

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/*
 * annotation的target是一个被标注的程序元素。
 * target说明了annotation所修饰的对象范围：
 *   annotation可被用于packages、types（类、接口、枚举、annotation类型）、
 *   类型成员（方法、构造方法、成员变量、枚举值）、
 *   方法参数和本地变量（如循环变量、catch参数）。
 * 在annotation类型的声明中使用了target可更加明晰其修饰的目标。
 * 如果不添加则默认为都可以修饰
 */
@Target(ElementType.TYPE)
/*
 * annotation的retention定义了该annotation被保留的时间长短：
 *   某些annotation仅出现在源代码中，而被编译器丢弃；
 *   而另一些却被编译在class文件中；
 *   编译在class文件中的annotation可能会被虚拟机忽略，
 *   而另一些在class被装载时将被读取（请注意并不影响class的执行，因为annotation与class在使用上是被分离的）。
 * 使用这个meta-annotation可以对annotation的“生命周期”限制。
 */
@Retention(RetentionPolicy.RUNTIME)
    public @interface Twizzle {
        @Edible
            int mem() default 1;

        /*
         * annotation的成员在annotation类型中以无参数的方法的形式被声明。其方法名和返回值定义了该成员的名字和类型
         * 在此有一个特定的默认语法
         * ：允许声明任何annotation成员的默认值：一个annotation可以将name=value对作为没有定义默认值的annotation成员的值
         * ， 当然也可以使用name=value对来覆盖其它成员默认值。
         * 这一点有些近似类的继承特性，父类的构造函数可以作为子类的默认构造函数，但是也可以被子类覆盖 。
         */
        String name() default "Jack";
    }

@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
@interface Edible {
	boolean value() default false;

	String name() default "John";
}

//A.java
package demo;

import java.lang.annotation.Annotation;
import java.lang.reflect.AnnotatedElement;
import java.lang.reflect.Method;

//针对类的标注
@Twizzle
public class A {

    //marker annotation
    @Deprecated
        public void run()
        {

        }

    public void test()
    {
        AnnotatedElement target = B.class;
        Twizzle t = target.getAnnotation(Twizzle.class);
        //访问字段
        System.out.println(t);
        for(Annotation a : Twizzle.class.getAnnotations()){
            System.out.println(a);
        }
        System.out.println("----------------");
        target = Twizzle.class;
        for(Annotation a:target.getDeclaredAnnotations()){
            System.out.println(a);
        }
    }

    public static void main(String[] args)
    {
        (new A()).test();
    }
}

//自定义默认值的标注
@Twizzle(
        name="Lucy",
        mem = 2
        )
class B{

}
```

