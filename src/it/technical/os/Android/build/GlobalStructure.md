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
