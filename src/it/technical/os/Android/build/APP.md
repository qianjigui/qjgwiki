---
title: Android APP 模块编译过程学习
tags: Make APP
tagline: 将Makefile打造成OOP
---

# 一个例子

## 模块编译并明确需要分析的过程

1. 以下是进入一个已经编译完成的项目, 项目环境要求:
    - PLATFORM_VERSION_CODENAME=REL
    - PLATFORM_VERSION=4.2.2
    - TARGET_PRODUCT=full_maguro
    - TARGET_BUILD_VARIANT=userdebug
    - TARGET_BUILD_TYPE=release
    - TARGET_BUILD_APPS=
    - TARGET_ARCH=arm
    - TARGET_ARCH_VARIANT=armv7-a-neon
    - HOST_ARCH=x86
    - HOST_OS=linux
    - HOST_OS_EXTRA=Linux-3.0.0-32-server-x86_64-with-Ubuntu-11.10-oneiric
    - HOST_BUILD_TYPE=release
    - BUILD_ID=JDQ39E
    - OUT_DIR=out

    其中,请注意需要使用userdebug版本,这样整个编译流程可以完全覆盖.
2. 进入我们需要进行编译的模块

    ``` shell
    # Go to root
    croot
    # Go to Calculator which is a common module
    cd packages/apps/Calculator
    ```

3. 删除我们不关心的模块编译过程

    ``` diff
    diff --git a/Android.mk b/Android.mk
    index 90f5b5f..79b62a6 100644
    --- a/Android.mk
    +++ b/Android.mk
    @@ -28,12 +28,3 @@ LOCAL_SDK_VERSION := current
     LOCAL_PACKAGE_NAME := Calculator

     include $(BUILD_PACKAGE)
    -##################################################
    -include $(CLEAR_VARS)
    -
    -LOCAL_PREBUILT_STATIC_JAVA_LIBRARIES := libarity:arity-2.1.2.jar
    -
    -include $(BUILD_MULTI_PREBUILT)
    -
    -# Use the folloing include to make our test apk.
    -include $(call all-makefiles-under,$(LOCAL_PATH))
    ```

4. 动态编译,获取中间结果

    ``` shell
    mm -B --debug=b | tee basicdebug.log
    grep target basicdebug.log | grep Successfully
          Successfully remade target file `out/target/common/obj/APPS/Calculator_intermediates/src/R.stamp'.
                      Successfully remade target file `out/target/common/obj/APPS/Calculator_intermediates/classes-full-debug.jar'.
                    Successfully remade target file `out/target/common/obj/APPS/Calculator_intermediates/classes-jarjar.jar'.
                  Successfully remade target file `out/target/common/obj/APPS/Calculator_intermediates/emma_out/lib/classes-jarjar.jar'.
                Successfully remade target file `out/target/common/obj/APPS/Calculator_intermediates/classes.jar'.
              Successfully remade target file `out/target/common/obj/APPS/Calculator_intermediates/proguard.classes.jar'.
            Successfully remade target file `out/target/common/obj/APPS/Calculator_intermediates/proguard.classes-with-local.dex'.
          Successfully remade target file `out/target/common/obj/APPS/Calculator_intermediates/proguard.classes.dex'.
        Successfully remade target file `out/target/product/maguro/obj/APPS/Calculator_intermediates/package.apk'.
          Successfully remade target file `out/target/product/maguro/obj/NOTICE_FILES/src//system/app/Calculator.apk.txt'.
        Successfully remade target file `out/target/product/maguro/system/app/Calculator.apk'.
      Successfully remade target file `Calculator'.
    Successfully remade target file `all_modules'.
    ```

    从中,我们可以看到整个Calculator模块的编译涉及这些中间模块:
    - out/target/common/obj/APPS/Calculator_intermediates/src/R.stamp
    - out/target/common/obj/APPS/Calculator_intermediates/classes-full-debug.jar
    - out/target/common/obj/APPS/Calculator_intermediates/classes-jarjar.jar
    - out/target/common/obj/APPS/Calculator_intermediates/emma_out/lib/classes-jarjar.jar
    - out/target/common/obj/APPS/Calculator_intermediates/classes.jar
    - out/target/common/obj/APPS/Calculator_intermediates/proguard.classes.jar
    - out/target/common/obj/APPS/Calculator_intermediates/proguard.classes-with-local.dex
    - out/target/common/obj/APPS/Calculator_intermediates/proguard.classes.dex
    - out/target/product/maguro/obj/APPS/Calculator_intermediates/package.apk
    - out/target/product/maguro/obj/NOTICE_FILES/src//system/app/Calculator.apk.txt
    - out/target/product/maguro/system/app/Calculator.apk
    - Calculator
    - all_modules

## 过程分析

首先我们同样通过make系统动态获取编译的命令:

    mm -B --debug=b -n | tee compilecmds.log

下面我们一个个分析各过程.

### out/target/common/obj/APPS/Calculator_intermediates/src/R.stamp

通过aapt工具生成R.java,并cp成R.stamp

``` shell
# 将资源进行编号,ID化
echo "target R.java/Manifest.java: Calculator (out/target/common/obj/APPS/Calculator_intermediates/src/R.stamp)"
# rm old R.stamp
rm -f out/target/common/obj/APPS/Calculator_intermediates/src/R.stamp
mkdir -p out/target/common/obj/APPS/Calculator_intermediates/src
mkdir -p out/target/common/obj/APPS/Calculator_intermediates/
# aapt for generating R.java, 注意生成了R.java
out/host/linux-x86/bin/aapt package -z -m  -J out/target/common/obj/APPS/Calculator_intermediates/src -M packages/apps/Calculator/AndroidManifest.xml -P out/target/common/obj/APPS/Calculator_intermediates/public_resources.xml -S packages/apps/Calculator/res  -I out/target/common/obj/APPS/framework-res_intermediates/package-export.apk -G out/target/common/obj/APPS/Calculator_intermediates/proguard_options --min-sdk-version 17 --target-sdk-version 17 --version-code 17 --version-name 4.2.2-eng.pengcheng.wang.20140103.172137--
# copy all Manifest.java to out/target/common/R/
for GENERATED_MANIFEST_FILE in `find out/target/common/obj/APPS/Calculator_intermediates/src \
>--->--->--->--->----name Manifest.java 2> /dev/null`; do \
>--->---dir=`awk '/package/{gsub(/\./,"/",$2);gsub(/;/,"",$2);print $2;exit}' $GENERATED_MANIFEST_FILE`; \
>--->---mkdir -p out/target/common/R/$dir; \
>--->---out/host/linux-x86/bin/acp -fp $GENERATED_MANIFEST_FILE out/target/common/R/$dir; \
>---done;
# copy all R.java to out/target/common/R/
#          copy R.java to R.stamp
for GENERATED_R_FILE in `find out/target/common/obj/APPS/Calculator_intermediates/src \
>--->--->--->--->----name R.java 2> /dev/null`; do \
>--->---dir=`awk '/package/{gsub(/\./,"/",$2);gsub(/;/,"",$2);print $2;exit}' $GENERATED_R_FILE`; \
>--->---mkdir -p out/target/common/R/$dir; \
>--->---out/host/linux-x86/bin/acp -fp $GENERATED_R_FILE out/target/common/R/$dir \
>--->--->---|| exit 31; \
>--->---out/host/linux-x86/bin/acp -fp $GENERATED_R_FILE out/target/common/obj/APPS/Calculator_intermediates/src/R.stamp || exit 32; \
>---done; \

      Successfully remade target file `out/target/common/obj/APPS/Calculator_intermediates/src/R.stamp'.
```

### out/target/common/obj/APPS/Calculator_intermediates/classes-full-debug.jar

基于R.java, 依赖包, 源代码编译成 classes-full-debug.jar

```shell
# 生成Java classes 保存为 classes-full-debug.jar
echo "target Java: Calculator (out/target/common/obj/APPS/Calculator_intermediates/classes)"
rm -f out/target/common/obj/APPS/Calculator_intermediates/classes-full-debug.jar
rm -rf out/target/common/obj/APPS/Calculator_intermediates/classes
mkdir -p out/target/common/obj/APPS/Calculator_intermediates/
mkdir -p out/target/common/obj/APPS/Calculator_intermediates/classes
# 检查该模块依赖的中间文件
for f in  out/target/common/obj/JAVA_LIBRARIES/libarity_intermediates/javalib.jar  out/target/common/obj/JAVA_LIBRARIES/android-support-v4_intermediates/javalib.jar  out/target/common/obj/JAVA_LIBRARIES/guava_intermediates/javalib.jar; do if [ ! -f $f ]; then echo Missing file $f; exit 1; fi; unzip -qo $f -d out/target/common/obj/APPS/Calculator_intermediates/classes; done ;rm -rf out/target/common/obj/APPS/Calculator_intermediates/classes/META-INF
# 保存一个中间的java源代码列表, 将列表进行保存便于去重与防止bash参数过长(getconf ARG_MAX)
rm -f out/target/common/obj/APPS/Calculator_intermediates/classes/java-source-list
echo -n 'packages/apps/Calculator/src/com/android/calculator2/ColorButton.java packages/apps/Calculator/src/com/android/calculator2/CalculatorEditable.java packages/apps/Calculator/src/com/android/calculator2/CalculatorEditText.java packages/apps/Calculator/src/com/android/calculator2/History.java packages/apps/Calculator/src/com/android/calculator2/EventListener.java packages/apps/Calculator/src/com/android/calculator2/Persist.java packages/apps/Calculator/src/com/android/calculator2/CalculatorDisplay.java packages/apps/Calculator/src/com/android/calculator2/Logic.java packages/apps/Calculator/src/com/android/calculator2/Calculator.java packages/apps/Calculator/src/com/android/calculator2/PanelSwitcher.java packages/apps/Calculator/src/com/android/calculator2/CalculatorViewPager.java packages/apps/Calculator/src/com/android/calculator2/HistoryEntry.java packages/apps/Calculator/src/com/android/calculator2/HistoryAdapter.java ' >> out/target/common/obj/APPS/Calculator_intermediates/classes/java-source-list
if [ -d "out/target/common/obj/APPS/Calculator_intermediates/src" ]; then find out/target/common/obj/APPS/Calculator_intermediates/src -name '*.java' >> out/target/common/obj/APPS/Calculator_intermediates/classes/java-source-list; fi
tr ' ' '\n' < out/target/common/obj/APPS/Calculator_intermediates/classes/java-source-list | sort -u > out/target/common/obj/APPS/Calculator_intermediates/classes/java-source-list-uniq
# javac 走起
if [ -s out/target/common/obj/APPS/Calculator_intermediates/classes/java-source-list-uniq ] ; then javac -J-Xmx512M -target 1.5 -Xmaxerrs 9999999 -encoding UTF-8 -g  -bootclasspath out/target/common/obj/JAVA_LIBRARIES/android_stubs_current_intermediates/classes.jar -classpath out/target/common/obj/JAVA_LIBRARIES/android_stubs_current_intermediates/classes.jar:out/target/common/obj/JAVA_LIBRARIES/libarity_intermediates/javalib.jar:out/target/common/obj/JAVA_LIBRARIES/android-support-v4_intermediates/javalib.jar:out/target/common/obj/JAVA_LIBRARIES/guava_intermediates/javalib.jar  -extdirs "" -d out/target/common/obj/APPS/Calculator_intermediates/classes  \@out/target/common/obj/APPS/Calculator_intermediates/classes/java-source-list-uniq || ( rm -rf out/target/common/obj/APPS/Calculator_intermediates/classes ; exit 41 ) fi
rm -f out/target/common/obj/APPS/Calculator_intermediates/classes/java-source-list
rm -f out/target/common/obj/APPS/Calculator_intermediates/classes/java-source-list-uniq
# jar 打包
jar -cf out/target/common/obj/APPS/Calculator_intermediates/classes-full-debug.jar  -C out/target/common/obj/APPS/Calculator_intermediates/classes .
                  Successfully remade target file `out/target/common/obj/APPS/Calculator_intermediates/classes-full-debug.jar'.
```

### out/target/common/obj/APPS/Calculator_intermediates/classes-jarjar.jar

cp classes-full-debug.jar intermediates/classes-jarjar.jar

```shell
# 生成classes-jarjar.jar
echo Copying: out/target/common/obj/APPS/Calculator_intermediates/classes-jarjar.jar
# acp: Android cp command
out/host/linux-x86/bin/acp -fp out/target/common/obj/APPS/Calculator_intermediates/classes-full-debug.jar out/target/common/obj/APPS/Calculator_intermediates/classes-jarjar.jar
                Successfully remade target file `out/target/common/obj/APPS/Calculator_intermediates/classes-jarjar.jar'.
```

### out/target/common/obj/APPS/Calculator_intermediates/emma_out/lib/classes-jarjar.jar

cp intermediates/classes-jarjar.jar emma_out/lib/classes-jarjar.jar

```shell
# 生成存放在emma_out下的classes-jarjar.jar
echo Copying: out/target/common/obj/APPS/Calculator_intermediates/emma_out/lib/classes-jarjar.jar
mkdir -p out/target/common/obj/APPS/Calculator_intermediates/emma_out/lib/
out/host/linux-x86/bin/acp -fp out/target/common/obj/APPS/Calculator_intermediates/classes-jarjar.jar out/target/common/obj/APPS/Calculator_intermediates/emma_out/lib/classes-jarjar.jar
              Successfully remade target file `out/target/common/obj/APPS/Calculator_intermediates/emma_out/lib/classes-jarjar.jar'.
```

### out/target/common/obj/APPS/Calculator_intermediates/classes.jar

cp intermediates/emma\_out/lib/classes-jarjar.jar classes.jar

```shell
# 生成classes.jar
echo Copying: out/target/common/obj/APPS/Calculator_intermediates/classes.jar
out/host/linux-x86/bin/acp -fp out/target/common/obj/APPS/Calculator_intermediates/emma_out/lib/classes-jarjar.jar out/target/common/obj/APPS/Calculator_intermediates/classes.jar
            Successfully remade target file `out/target/common/obj/APPS/Calculator_intermediates/classes.jar'.
```

### out/target/common/obj/APPS/Calculator_intermediates/proguard.classes.jar

通过proguard.sh基于classes.jar生成proguard.classes.jar

```shell
echo Proguard: out/target/common/obj/APPS/Calculator_intermediates/proguard.classes.jar
external/proguard/bin/proguard.sh -injars out/target/common/obj/APPS/Calculator_intermediates/classes.jar -outjars out/target/common/obj/APPS/Calculator_intermediates/proguard.classes.jar -libraryjars out/target/common/obj/JAVA_LIBRARIES/android_stubs_current_intermediates/classes.jar -include build/core/proguard.flags -forceprocessing -printmapping out/target/common/obj/APPS/Calculator_intermediates/proguard_dictionary -include out/target/common/obj/APPS/Calculator_intermediates/proguard_options---
          Successfully remade target file `out/target/common/obj/APPS/Calculator_intermediates/proguard.classes.jar'.
```

### out/target/common/obj/APPS/Calculator_intermediates/proguard.classes-with-local.dex

基于proguard.classes.jar通过dx生成proguard.classes-with-local.dex

```shell
echo "target Dex: Calculator"
mkdir -p out/target/common/obj/APPS/Calculator_intermediates/
out/host/linux-x86/bin/dx -JXms16M -JXmx2048M --dex --output=out/target/common/obj/APPS/Calculator_intermediates/proguard.classes-with-local.dex     out/target/common/obj/APPS/Calculator_intermediates/proguard.classes.jar
        Successfully remade target file `out/target/common/obj/APPS/Calculator_intermediates/proguard.classes-with-local.dex'.
```

### out/target/common/obj/APPS/Calculator_intermediates/proguard.classes.dex

cp proguard.classes-with-local.dex proguard.classes.dex

```shell
echo Copying: out/target/common/obj/APPS/Calculator_intermediates/proguard.classes.dex
out/host/linux-x86/bin/acp -fp out/target/common/obj/APPS/Calculator_intermediates/proguard.classes-with-local.dex out/target/common/obj/APPS/Calculator_intermediates/proguard.classes.dex
      Successfully remade target file `out/target/common/obj/APPS/Calculator_intermediates/proguard.classes.dex'.
```

### out/target/product/maguro/obj/APPS/Calculator_intermediates/package.apk

整体步骤:

1. create a zip
2. add resources to zip
3. add dex to zip
4. update zip by jar flags
5. signature zip
6. Alignment zip

```shell
echo "target Package: Calculator (out/target/product/maguro/obj/APPS/Calculator_intermediates/package.apk)"
mkdir -p out/target/product/maguro/obj/APPS/Calculator_intermediates/
# make a empty file for create a zip
touch out/target/product/maguro/obj/APPS/Calculator_intermediates//dummy
(cd out/target/product/maguro/obj/APPS/Calculator_intermediates/ && jar cf package.apk dummy)
# create a zip with empty dummy file
zip -qd out/target/product/maguro/obj/APPS/Calculator_intermediates/package.apk dummy
# rm dummy
rm out/target/product/maguro/obj/APPS/Calculator_intermediates//dummy
# Add resouces to zip
out/host/linux-x86/bin/aapt package -u -z -c en_US,en_US,cs_CZ,da_DK,de_AT,de_CH,de_DE,de_LI,el_GR,en_AU,en_CA,en_GB,en_NZ,en_SG,eo_EU,es_ES,fr_CA,fr_CH,fr_BE,fr_FR,it_CH,it_IT,ja_JP,ko_KR,nb_NO,nl_BE,nl_NL,pl_PL,pt_PT,ru_RU,sv_SE,tr_TR,zh_CN,zh_HK,zh_TW,am_ET,hi_IN,en_US,fr_FR,it_IT,es_ES,de_DE,nl_NL,cs_CZ,pl_PL,ja_JP,zh_TW,zh_CN,ru_RU,ko_KR,nb_NO,es_US,da_DK,el_GR,tr_TR,pt_PT,pt_BR,rm_CH,sv_SE,bg_BG,ca_ES,en_GB,fi_FI,hi_IN,hr_HR,hu_HU,in_ID,iw_IL,lt_LT,lv_LV,ro_RO,sk_SK,sl_SI,sr_RS,uk_UA,vi_VN,tl_PH,ar_EG,fa_IR,th_TH,sw_TZ,ms_MY,af_ZA,zu_ZA,am_ET,hi_IN,normal,hdpi,xhdpi,nodpi --preferred-configurations xhdpi -M packages/apps/Calculator/AndroidManifest.xml -S packages/apps/Calculator/res  -I out/target/common/obj/APPS/framework-res_intermediates/package-export.apk --min-sdk-version 17 --target-sdk-version 17 --product nosdcard --version-code 17 --version-name 4.2.2-eng.pengcheng.wang.20140103.172137   -F out/target/product/maguro/obj/APPS/Calculator_intermediates/package.apk
# add dex to zip
_adtp_classes_dex=out/target/common/obj/APPS/Calculator_intermediates/classes.dex; cp out/target/common/obj/APPS/Calculator_intermediates/proguard.classes.dex $_adtp_classes_dex && out/host/linux-x86/bin/aapt add -k out/target/product/maguro/obj/APPS/Calculator_intermediates/package.apk $_adtp_classes_dex && rm -f $_adtp_classes_dex
# update zip by jar flags
if [ -d out/target/common/obj/APPS/Calculator_intermediates/classes ] ; then java_res_jar_flags=$(find out/target/common/obj/APPS/Calculator_intermediates/classes -type f -a -not -name "*.class" | sed -e "s?^out/target/common/obj/APPS/Calculator_intermediates/classes/? -C out/target/common/obj/APPS/Calculator_intermediates/classes ?"); if [ -n "$java_res_jar_flags" ] ; then echo $java_res_jar_flags >out/target/product/maguro/obj/APPS/Calculator_intermediates/java_res_jar_flags; jar uf out/target/product/maguro/obj/APPS/Calculator_intermediates/package.apk $java_res_jar_flags; fi; fi
# Prepare for signature
mv out/target/product/maguro/obj/APPS/Calculator_intermediates/package.apk out/target/product/maguro/obj/APPS/Calculator_intermediates/package.apk.unsigned
# signature
java -jar out/host/linux-x86/framework/signapk.jar build/target/product/security/testkey.x509.pem build/target/product/security/testkey.pk8 out/target/product/maguro/obj/APPS/Calculator_intermediates/package.apk.unsigned out/target/product/maguro/obj/APPS/Calculator_intermediates/package.apk.signed
# Finish signature
mv out/target/product/maguro/obj/APPS/Calculator_intermediates/package.apk.signed out/target/product/maguro/obj/APPS/Calculator_intermediates/package.apk
# Prepare for Alignment
# Alignment must happen after all other zip operations.
mv out/target/product/maguro/obj/APPS/Calculator_intermediates/package.apk out/target/product/maguro/obj/APPS/Calculator_intermediates/package.apk.unaligned
# Alignment
out/host/linux-x86/bin/zipalign -f 4 out/target/product/maguro/obj/APPS/Calculator_intermediates/package.apk.unaligned out/target/product/maguro/obj/APPS/Calculator_intermediates/package.apk.aligned
# To apk
mv out/target/product/maguro/obj/APPS/Calculator_intermediates/package.apk.aligned out/target/product/maguro/obj/APPS/Calculator_intermediates/package.apk
    Successfully remade target file `out/target/product/maguro/obj/APPS/Calculator_intermediates/package.apk'.
```

### out/target/product/maguro/obj/NOTICE_FILES/src//system/app/Calculator.apk.txt

cp NOTICE to Calculator.apk.txt

```shell
echo Notice file: packages/apps/Calculator/NOTICE -- out/target/product/maguro/obj/NOTICE_FILES/src//system/app/Calculator.apk.txt
mkdir -p out/target/product/maguro/obj/NOTICE_FILES/src//system/app/
cat packages/apps/Calculator/NOTICE >> out/target/product/maguro/obj/NOTICE_FILES/src//system/app/Calculator.apk.txt
      Successfully remade target file `out/target/product/maguro/obj/NOTICE_FILES/src//system/app/Calculator.apk.txt'.
```

### out/target/product/maguro/system/app/Calculator.apk

cp package.apk Calculator.apk

```shell
echo "Install: out/target/product/maguro/system/app/Calculator.apk"
mkdir -p out/target/product/maguro/system/app/
out/host/linux-x86/bin/acp -fp out/target/product/maguro/obj/APPS/Calculator_intermediates/package.apk out/target/product/maguro/system/app/Calculator.apk
    Successfully remade target file `out/target/product/maguro/system/app/Calculator.apk'.
```

## 过程回顾

### 从中看到的一般流程

来自[Android官方](http://developer.android.com/tools/building/index.html#detailed-build)的解释:
![Android APK Build Steps](http://developer.android.com/images/build.png)

The general process for a typical build is outlined below:

1. The Android Asset Packaging Tool (aapt) takes your application resource files, such as the AndroidManifest.xml file and the XML files for your Activities, and compiles them. An R.java is also produced so you can reference your resources from your Java code.
2. The aidl tool converts any .aidl interfaces that you have into Java interfaces.
3. All of your Java code, including the R.java and .aidl files, are compiled by the Java compiler and .class files are output.
4. The dex tool converts the .class files to Dalvik byte code. Any 3rd party libraries and .class files that you have included in your project are also converted into .dex files so that they can be packaged into the final .apk file.
5. All non-compiled resources (such as images), compiled resources, and the .dex files are sent to the apkbuilder tool to be packaged into an .apk file.
6. Once the .apk is built, it must be signed with either a debug or release key before it can be installed to a device.
7. Finally, if the application is being signed in release mode, you must align the .apk with the zipalign tool. Aligning the final .apk decreases memory usage when the application is running on a device.

整体分为如下过程:

1. 资源ID准备
    1. aapt to R.java
    2. aidl to Java interfaces
2. 运行时文件生成
    1. javac to classes
    2. classes 级优化与包装
        1. proguard
    3. dx to dex
3. apk 组装
    1. empty zip
    2. add resources
    3. add dex
    4. update zip
        1. jar flags
        2. signature
        3. zipalign

### 各个中间文件的作用

各模块在编译系统中的对应关系与具体作用:

- out/target/common/obj/APPS/Calculator_intermediates/src/R.stamp
    - R.java stub
    - R_file_stamp
- out/target/common/obj/APPS/Calculator_intermediates/classes-full-debug.jar
    - LOCAL_EMMA_INSTRUMENT == false
    - emma 测试覆盖工具
    - full_classes_compiled_jar_leaf
    - full_classes_compiled_jar
- out/target/common/obj/APPS/Calculator_intermediates/classes-jarjar.jar
    - LOCAL_JARJAR_RULES != ''
    - [A utility to repackage and embed Java libraries](http://www.xinotes.org/notes/note/1468/)
    - 可以重新指定类中的package引用名
    - full_classes_jarjar_jar
- out/target/common/obj/APPS/Calculator_intermediates/emma_out/lib/classes-jarjar.jar
    - full_classes_emma_jar
- out/target/common/obj/APPS/Calculator_intermediates/classes.jar
    - full_classes_jar
- out/target/common/obj/APPS/Calculator_intermediates/proguard.classes.jar
    - full_classes_proguard_jar
- out/target/common/obj/APPS/Calculator_intermediates/proguard.classes-with-local.dex
    - LOCAL_EMMA_INSTRUMENT == false
    - built_dex_intermediate
- out/target/common/obj/APPS/Calculator_intermediates/proguard.classes.dex
    - built_dex
- out/target/product/maguro/obj/APPS/Calculator_intermediates/package.apk
    - LOCAL_BUILT_MODULE_STEM
- out/target/product/maguro/obj/NOTICE_FILES/src//system/app/Calculator.apk.txt
- out/target/product/maguro/system/app/Calculator.apk
    - LOCAL_BUILT_MODULE
- Calculator
    - LOCAL_PACKAGE_NAME
- all_modules

# 编译脚本

## 具体组织结构

## 提供给开发者的控制参数