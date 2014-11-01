---
title: 测试驱动开发
tags: TDD
tagline: 通过开发模式来保证开发质量与效率
---

本文主要是[测试驱动开发的艺术][1]的读书笔记.

[1]: http://book.douban.com/subject/5326182/ "测试驱动开发的艺术"

# 综述

## 正确地做事

开发的主要流程:

1. 测试
2. 编码
3. 重构

上述过程结合增量式开发模式, 以更好地保证应用需求变化.

## 主要工具

* 单元测试框架 xUnit
* 结合持续集成及构建
* 引入静态与动态代码质量分析工具:
    * PMD
    * checkstyle
    * findbug
    * lint
    * 代码覆盖率分析

# TDD 的概念与模式

## 如何编写及通过测试

### 编写测试

#### 测试选择技巧

* 深入细节与整体考虑
    * 细节优先(深度优先): 便于发现关键技术点
    * 整体优先(宽度优先): 便于验证整体架构
* 探索未知与轻车熟路
    * 优先编写不确定因素少的测试
* 最大限度地获取价值与摘取现成果实
    * 优先测试基本功能再处理边界问题
* 走通基本功能路径与行处理出错情况
    * 先保证基本路径

#### 实现技巧

* 伪实现
* 三角法
* 简单地实现

#### 测试驱动的基本准则

* 绝不路过重构
* 尽快变绿
* 犯错后减慢速度

## 重要的测试概念

* 夹具(fixtures)是测试的上下文
    * 测试过程中的状态维护体
* 用测试替身(mock)替换依赖
    * 测试基本形式就是方法调用: 构造需要的参数, 调用, 再检查返回的结果; 替身在这里主要用于构造参数
* 基于状态与基于交互的测试不同
    * 基于状态的测试利用对象内部状态来验证运行结果的正确性

            @Test
            public void listShouldNotBeEmptyAfterAddingSomethingToIt() throws Exception {
                List<String> list = new ArrayList<String>();
                assertTrue(list.isEmpty());
                list.add("Something");
                assertFalse(list.isEmpty());
            }

    * 基于交互的测试主要关注整个调用的过程
        * 由于涉及完整的交互, 我们就需要单独构建与其交互的对象实例, 这时就需要使用动态模拟对象库(dynamic mock objects library): EasyMock, jMock

## 测试替身

用于是用于模拟真实的对象,

* 测试桩: 给定接口最简单的实现, 主要是硬编码数据
* 伪实现
* 模拟对象: 可以完成对象构建, 状态模拟与过程录制

```java
import static org.easymock.classextension.EasyMock.*;
import static org.juni.Assert.*;
import org.junit.*;

public class OrderProcessorEasymockTest{
    @Test
    public void testOrderProcessorWithEasyMock() throws Exception {
        //为测试准备普通对象和数据
        float initialBalance = 100.0f;
        float listPrice = 30.0f;
        float discount = 10.0f;
        float expectedBalance = 
            initialBalance - (listPrice*(1-discount/100));
        Customer customer = new Customer(initialBalance);
        Product product = new Product("TDD in action", listPrice);

        //模拟对象 创建过程
        //通过模拟对象创建动态模拟过程中的相关假对象
        PricingService mock = createMock(PricingService.class);
        //BDD模式,调用输入与期望输出, 后期统一对状态进行测试
        expect(mock.getDiscountPercentage(customer, product).addReturn(discount));

        replay(mock);//进入播放模式

        //待测对象 中间利用模拟对象完成部分交互
        //测试OrderProcessor
        OrderProcessor processor = new OrderProcessor();
        processor.setPricingService(mock);//注入依赖
        processor.process(new Order(customer, product));//正常调用过程

        assertEquals(expectedBalance, customer.getBalance(), 0.001f);
        verify(mock);//验证输入输出

    }
}
```

## 提高设计的可测试性的准则

* 多使用组合而不是继承
* 不要使用static 关键字以及单例模式
* 隔离依赖
* 注入依赖

## 测试的主要模式

### 单元测试

* 断言模式: 状态的基本测试
* 防卫模式: 在获取到测试用数据后先验证数据本身
* 差值断言
* 自定义断言
* 交互断言

### 夹具

* 参数化创建方法
    * 基本对象不要硬编码
* 对象生产
    * 工厂模式
* 自动清理
    * 测试前清理测试现场

### 测试过程

* 参数化
* 自分流
* 测试内部数据共享: 利用闭包/内部类进行数据分享
* 待测试对象的状态: 通过反射进行完整扫描
* 添加专用处理类


# 测试驱动数据访问

## 文件系统访问

我们需要尽量避免访问文件系统, 使用java.io.Writer及java.io.Reader.
毕竟大部分时间我们感兴趣的是文件内容, 不是文件本身, 使用streams完全可以胜任.

### 提高文件访问的可测试性的实践

1. 用接口隔离文件访问
2. 使用流(stream)而非文件
3. 使用自定义的文件对象
    * 将文件内容和文件信息(元数据)关联起来
    * 使用内存性的文件系统, 性能更快
4. 使用专用的临时文件夹
    * 将所有的测试数据放在一个文件夹, 便于统一地处理(创建与清理)
5. 测试前清理而非测试后

