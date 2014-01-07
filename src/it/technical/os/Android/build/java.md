---
title: Android java 模块编译过程学习
tags: Make
tagline: 将Makefile打造成OOP
---

# 编译脚本分析

- build/core/java.mk
    - 配置基础编译依赖包
        - 根据 LOCAL_NO_STANDARD\_LIBRARIES, LOCAL_SDK_VERSION, proto等上下文添加依赖包.
        - 标准SDK, 需要添加 core core-junit ext framework
    - 标准中间模块添加

        ```shell
        LOCAL_INTERMEDIATE_TARGETS += \
            $(full_classes_compiled_jar) \
            $(full_classes_jarjar_jar) \
            $(full_classes_emma_jar) \
            $(full_classes_jar) \
            $(full_classes_proguard_jar) \
            $(built_dex_intermediate) \
            $(built_dex) \
            $(full_classes_stubs_jar)
        ```

    - 可能的中间模块
        - RenderScript/FilterScript to .java/.bc
    - build/core/base_rules.mk
    - 具体中间文件生成规则
        - create common directories
        - full_classes_compiled_jar: java -> classes -> compiled-jar
        - full_classes_jarjar_jar: acp/jarjar compiled-jar -> jarjar-jar
        - full_classes_emma_jar: acp/emmajar jarjar-jar -> emma-jar
        - full_classes_jar: acp emma-jar -> classses-jar
        - full_classes_proguard_jar: acp/proguard classes-jar -> proguard-jar
        - built_dex_intermediate: dx proguard-jar -> dex-in
        - built_dex: acp dex-in -> dex

## 关键上下文接入点

### Input
- LOCAL_BUILT_MODULE_STEM
- LOCAL_JAVA_LIBRARIES

### Output
- LOCAL_INTERMEDIATE_TARGETS

### 整体依赖关系

```shell
make all_modules
all\_modules : $(ALL_MODULES)
ALL\_MODULES += $(LOCAL_MODULE)
$(LOCAL_MODULE): $(LOCAL_BUILT_MODULE) $(LOCAL_INSTALLED_MODULE)
$(LOCAL_INSTALLED_MODULE): $(LOCAL_BUILT_MODULE)

LOCAL_BUILT_MODULE := $(built_module_path)/$(LOCAL_BUILT_MODULE_STEM)
.......
```

通过让 *LOCAL_BUILT_MODULE* 产生对具体上下模块的依赖.

例如:

- package.mk

    ```shell
    $(LOCAL_BUILT_MODULE): $(built_dex)
    $(LOCAL_BUILT_MODULE): $(R_file_stamp)
    ```
