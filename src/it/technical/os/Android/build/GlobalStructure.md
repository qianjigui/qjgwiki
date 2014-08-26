---
title: Android 编译系统整体结构
tags: Make
tagline: 将Makefile打造成OOP
---

# 一张全景图

![Android Build System Global include relationship](/assets/svgfiles/AndroidBuildSystemGlobalIncludeview.svg )

## 注意细节

1. 请复制URL单独打开
2. 从文件名级别就可以看出整个体系结构的清晰
    1. 与系统环境与状态设置相关的main.mk
    2. 与具体编译业务相关的模块, 这些模块均依赖于base_rules.mk

# 主要工作流程

## 从mm开始

1. make从main.mk进入编译系统
    * 其中的`ONE_SHOT_MAKEFILE`变量已经设定值为mm对应目前的Android.mk的路径
2. main.mk中
    1. 整体使用的function定义(definitions.mk)
    2. 环境配置(config.mk)
    3. 编译依赖的检查
    4. 进入`ONE_SHOT_MAKEFILE`
3. ONE_SHOT_MAKEFILE
    1. CLEAR_VARS
    2. LOCAL_* 相关参数设置
    3. 关键点: `BUILD_XXXXXX`
        1. 例如: build/core/executable.mk

# 模块分析

## 基础模块分析

### lunch

这个阶段,shell竟然使用了make过程中的`$(info xxx)`进行上下文构建.

### base_rules.mk

### 功能

* 选择中间产生文件与最终生成文件
* AIDL Convert
* logtags
* proto Convert
* java compile
* 添加通用FLAGS信息
    * AAPT
* 模块安装: 最后输出Install的地方
    * `$(LOCAL_INSTALLED_MODULE): $(LOCAL_BUILT_MODULE) | $(ACP)`
    * odex

#### Input

* LOCAL_MODULE
* LOCAL_MODULE_TAGS
* LOCAL_MODULE_PATH
* Pick a name for the intermediate and final targets
    * LOCAL_MODULE_STEM
    * LOCAL_MODULE_SUFFIX
    * LOCAL_BUILT_MODULE_STEM
    * LOCAL_BUILT_MODULE

# 功能定制

## 由谁确定最终安装的文件?

其中的主要流程是:

1. PRODUCT_PACKAGES:
    * 由两部分组成, 首先是build下的product标准项目模块集合, 再有是各个device自己添加的产品
    * build/target/product/core.mk
        * `all_product_configs := $(get-all-product-makefiles)`
        * `get-all-product-makefiles return core.mk`
2. product_MODULES

        product_MODULES := $(PRODUCTS.$(INTERNAL_PRODUCT).PRODUCT_PACKAGES)
        product_MODULES := $(filter-out $(foreach p, $(product_MODULES), \
            $(PACKAGES.$(p).OVERRIDES)), $(product_MODULES))

3. product_FILES

         product_FILES := $(call module-installed-files, $(product_MODULES))

4. modules_to_install

        modules_to_install := $(sort \
            $(ALL_DEFAULT_INSTALLED_MODULES) \
            $(product_FILES) \
            $(foreach tag,$(tags_to_install),$($(tag)_MODULES)) \
            $(call get-tagged-modules, shell_$(TARGET_SHELL)) \
            $(CUSTOM_MODULES) \
          )

5. ALL_DEFAULT_INSTALLED_MODULES

        ALL_DEFAULT_INSTALLED_MODULES := $(modules_to_install)

6. make target 依赖关系
   * droid
   * droidcore
   * files
   * modules_to_install

## LOCAL_MODULE_TAGS 的作用是什么

在 *build/core/build-system.html* 文件中的描述为:

        Set LOCAL_MODULE_TAGS to any number of whitespace-separated tags. If the tag list is empty or contains droid, the module will get installed as part of a make droid. Modules with the tag shell_$(TARGET_SHELL) will also be installed. Otherwise, it will only get installed by running make <your-module> or with the make all pseudotarget.

用于控制模块在哪些模式下会进行安装.
但是在Android 4.2 以后, 控制权已经交给了 `PRODUCT_PACKAGES` 变量进行处理.

Android 4.2 以后的具体的状态对应: 

| LOCAL_MODULE_TAGS 包含| 作用 | 目前起作用的方法 |
|-----------------------|------|------------------|
| user  | 指定在User下进行安装 | PRODUCT_PACKAGES |
| gnu   | 模块是GPL/MPL 协议   |                  |
| test,samples  | 如果模块没有指定`LOCAL_MODULE_PATH`, 设置`partition_tag`为空, **不安装** . | LOCAL_MODULE_PATH |
| test  | 可以用于指定proguard使用的配置文件, 可以控制AAPT的参数(-z 资源存在性检查), 关闭EMMA |    |


目前Android4.2 上支持的值: `debug eng tests optional samples shell_ash shell_mksh`,
没有赋值时, 默认数据为`optional`.

