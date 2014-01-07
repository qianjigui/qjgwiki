---
title: Android APP 模块编译过程学习
tags: Make APP
tagline: 将Makefile打造成OOP
---

# 学习环境

Android: android-4.2.2_r1.2

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
    - [emma 测试覆盖工具](http://www.ibm.com/developerworks/cn/opensource/os-cn-emma)
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

### 中间整体加载的Makefile

完整的Makefile加载过程见下面的log:

```shell
This program built for x86_64-pc-linux-gnu
Reading makefiles...
Reading makefile `Makefile'...
Reading makefile `build/core/main.mk' (search path) (no ~ expansion)...
Reading makefile `build/core/help.mk' (search path) (no ~ expansion)...
Reading makefile `build/core/config.mk' (search path) (no ~ expansion)...
Reading makefile `build/core/pathmap.mk' (search path) (no ~ expansion)...
Reading makefile `cts/build/config.mk' (search path) (don't care) (no ~ expansion)...
Reading makefile `buildspec.mk' (search path) (don't care) (no ~ expansion)...
Reading makefile `build/core/envsetup.mk' (search path) (no ~ expansion)...
Reading makefile `build/core/version_defaults.mk' (search path) (no ~ expansion)...
Reading makefile `build/core/build_id.mk' (search path) (no ~ expansion)...
Reading makefile `build/core/product_config.mk' (search path) (no ~ expansion)...
Reading makefile `build/core/node_fns.mk' (search path) (no ~ expansion)...
Reading makefile `build/core/product.mk' (search path) (no ~ expansion)...
Reading makefile `build/core/device.mk' (search path) (no ~ expansion)...
Reading makefile `device/lge/mako/AndroidProducts.mk' (search path) (no ~ expansion)...
Reading makefile `device/generic/armv7-a-neon/AndroidProducts.mk' (search path) (no ~ expansion)...
Reading makefile `device/generic/armv7-a/AndroidProducts.mk' (search path) (no ~ expansion)...
Reading makefile `device/generic/x86/AndroidProducts.mk' (search path) (no ~ expansion)...
Reading makefile `device/generic/mips/AndroidProducts.mk' (search path) (no ~ expansion)...
Reading makefile `device/ti/panda/AndroidProducts.mk' (search path) (no ~ expansion)...
Reading makefile `device/sample/products/AndroidProducts.mk' (search path) (no ~ expansion)...
Reading makefile `device/asus/tilapia/AndroidProducts.mk' (search path) (no ~ expansion)...
Reading makefile `device/asus/grouper/AndroidProducts.mk' (search path) (no ~ expansion)...
Reading makefile `device/samsung/manta/AndroidProducts.mk' (search path) (no ~ expansion)...
Reading makefile `device/samsung/tuna/AndroidProducts.mk' (search path) (no ~ expansion)...
Reading makefile `device/samsung/toro/AndroidProducts.mk' (search path) (no ~ expansion)...
Reading makefile `device/samsung/toroplus/AndroidProducts.mk' (search path) (no ~ expansion)...
Reading makefile `device/samsung/maguro/AndroidProducts.mk' (search path) (no ~ expansion)...
Reading makefile `build/target/product/AndroidProducts.mk' (search path) (no ~ expansion)...
Reading makefile `device/samsung/maguro/full_maguro.mk' (search path) (no ~ expansion)...
Reading makefile `build/target/product/full_base_telephony.mk' (search path) (no ~ expansion)...
Reading makefile `build/target/product/full_base.mk' (search path) (no ~ expansion)...
Reading makefile `build/target/product/generic_no_telephony.mk' (search path) (no ~ expansion)...
Reading makefile `build/target/product/core.mk' (search path) (no ~ expansion)...
Reading makefile `build/target/product/base.mk' (search path) (no ~ expansion)...
Reading makefile `external/cibu-fonts/fonts.mk' (search path) (no ~ expansion)...
Reading makefile `external/lohit-fonts/fonts.mk' (search path) (no ~ expansion)...
Reading makefile `external/naver-fonts/fonts.mk' (search path) (no ~ expansion)...
Reading makefile `frameworks/base/data/fonts/fonts.mk' (search path) (no ~ expansion)...
Reading makefile `frameworks/base/data/keyboards/keyboards.mk' (search path) (no ~ expansion)...
Reading makefile `frameworks/base/data/keyboards/common.mk' (search path) (no ~ expansion)...
Reading makefile `build/target/product/locales_full.mk' (search path) (no ~ expansion)...
Reading makefile `build/target/product/languages_full.mk' (search path) (no ~ expansion)...
Reading makefile `external/svox/pico/lang/all_pico_languages.mk' (search path) (no ~ expansion)...
Reading makefile `external/svox/pico/lang/PicoLangDeDeInSystem.mk' (search path) (no ~ expansion)...
Reading makefile `external/svox/pico/lang/PicoLangEnGBInSystem.mk' (search path) (no ~ expansion)...
Reading makefile `external/svox/pico/lang/PicoLangEnUsInSystem.mk' (search path) (no ~ expansion)...
Reading makefile `external/svox/pico/lang/PicoLangEsEsInSystem.mk' (search path) (no ~ expansion)...
Reading makefile `external/svox/pico/lang/PicoLangFrFrInSystem.mk' (search path) (no ~ expansion)...
Reading makefile `external/svox/pico/lang/PicoLangItItInSystem.mk' (search path) (no ~ expansion)...
Reading makefile `frameworks/base/data/sounds/AllAudio.mk' (search path) (no ~ expansion)...
Reading makefile `frameworks/base/data/sounds/AudioPackage2.mk' (search path) (no ~ expansion)...
Reading makefile `frameworks/base/data/sounds/AudioPackage3.mk' (search path) (no ~ expansion)...
Reading makefile `frameworks/base/data/sounds/AudioPackage4.mk' (search path) (no ~ expansion)...
Reading makefile `frameworks/base/data/sounds/AudioPackage5.mk' (search path) (no ~ expansion)...
Reading makefile `frameworks/base/data/sounds/AudioPackage6.mk' (search path) (no ~ expansion)...
Reading makefile `frameworks/base/data/sounds/AudioPackage7.mk' (search path) (no ~ expansion)...
Reading makefile `frameworks/base/data/sounds/AudioPackage7alt.mk' (search path) (no ~ expansion)...
Reading makefile `frameworks/base/data/sounds/OriginalAudio.mk' (search path) (no ~ expansion)...
Reading makefile `build/target/product/telephony.mk' (search path) (no ~ expansion)...
Reading makefile `device/samsung/maguro/device.mk' (search path) (no ~ expansion)...
Reading makefile `device/samsung/tuna/device.mk' (search path) (no ~ expansion)...
Reading makefile `frameworks/native/build/phone-xhdpi-1024-dalvik-heap.mk' (search path) (no ~ expansion)...
Reading makefile `hardware/broadcom/wlan/bcmdhd/firmware/bcm4330/device-bcm.mk' (search path) (no ~ expansion)...
Reading makefile `hardware/ti/omap4xxx/omap4.mk' (search path) (no ~ expansion)...
Reading makefile `device/samsung/maguro/BoardConfig.mk' (search path) (no ~ expansion)...
Reading makefile `vendor/samsung/maguro/BoardConfigVendor.mk' (search path) (don't care) (no ~ expansion)...
Reading makefile `device/samsung/tuna/BoardConfig.mk' (search path) (no ~ expansion)...
Reading makefile `vendor/samsung/tuna/BoardConfigVendor.mk' (search path) (don't care) (no ~ expansion)...
Reading makefile `build/core/combo/select.mk' (search path) (no ~ expansion)...
Reading makefile `build/core/combo/HOST_linux-x86.mk' (search path) (no ~ expansion)...
Reading makefile `build/core/combo/select.mk' (search path) (no ~ expansion)...
Reading makefile `build/core/combo/TARGET_linux-arm.mk' (search path) (no ~ expansion)...
Reading makefile `build/core/combo/arch/arm/armv7-a-neon.mk' (search path) (no ~ expansion)...
Reading makefile `build/core/combo/javac.mk' (search path) (no ~ expansion)...
Reading makefile `build/core/llvm_config.mk' (search path) (no ~ expansion)...
Reading makefile `build/core/dumpvar.mk' (search path) (no ~ expansion)...
Reading makefile `build/core/cleanbuild.mk' (search path) (no ~ expansion)...
Reading makefile `build/core/cleanspec.mk' (search path) (no ~ expansion)...
Reading makefile `packages/apps/Calculator/CleanSpec.mk' (search path) (no ~ expansion)...
Reading makefile `out/target/product/maguro/clean_steps.mk' (search path) (don't care) (no ~ expansion)...
Reading makefile `out/target/product/maguro/previous_build_config.mk' (search path) (don't care) (no ~ expansion)...
Reading makefile `out/versions_checked.mk' (search path) (don't care) (no ~ expansion)...
Reading makefile `build/core/definitions.mk' (search path) (no ~ expansion)...
Reading makefile `build/core/distdir.mk' (search path) (no ~ expansion)...
Reading makefile `build/core/dex_preopt.mk' (search path) (no ~ expansion)...
Reading makefile `build/core/pdk_config.mk' (search path) (no ~ expansion)...
Reading makefile `packages/apps/Calculator/Android.mk' (search path) (no ~ expansion)...
Reading makefile `build/core/clear_vars.mk' (search path) (no ~ expansion)...
Reading makefile `build/core/package.mk' (search path) (no ~ expansion)...
Reading makefile `build/core/java.mk' (search path) (no ~ expansion)...
Reading makefile `build/core/base_rules.mk' (search path) (no ~ expansion)...
Reading makefile `build/core/notice_files.mk' (search path) (no ~ expansion)...
Reading makefile `build/core/post_clean.mk' (search path) (no ~ expansion)...
Reading makefile `build/core/legacy_prebuilts.mk' (search path) (no ~ expansion)...
Reading makefile `build/core/Makefile' (search path) (no ~ expansion)...
```

# 编译脚本

目前先关注主要的Makefile过程,后续从整体上分析整个系统的结构.
例如后续从APPS入手,分析整个编译系统的功能分布与依赖继承关系.

## Makefile加载的主要步骤
- Makefile
    - build/core/main.mk
        - packages/apps/Calculator/CleanSpec.mk
        - packages/apps/Calculator/Android.mk
            - build/core/clear_vars.mk
            - build/core/package.mk
                - build/core/java.mk
                    - build/core/base_rules.mk

## 具体运行过程
```shell
mm
    M=packages/apps/Calculator/Android.mk
    T=TOPDIR/Makefile
    ONE_SHOT_MAKEFILE=$M make -C $T all_modules $@
        $T include build/core/main.mk
            build/core/main.mk include $(ONE_SHOT_MAKEFILE)
```

## 各个过程的功能
1. mm 获取上下文与目标Android.mk后, 设置关键ONE_SHOT_MAKEFILE, 并进入make
2. build/core/main.mk
    - 设置系统环境
    - 定义目标
    - packages/apps/Calculator/Android.mk
        - 清理LOCAL_*变量
        - 定义编译模块相关的源代码等
        - build/core/package.mk
            - AndroidManifest指定
            - 应用资源指定
            - 模块依赖
                - PROGUARD
                - EMMA
            - build/core/java.mk
                - 依赖模块定义(JAVA\_LIBRARIES, STATIC_JAVA_LIBRARIES)
                - PROGUARD
                - renderscript
                - base/core/base_rules.mk
                    - 相关模块的依赖关系定义(主要用于与具体模块无关的上下文关系定义, 并可以明确需要安装的具体模块)
                    - .aidl to java
                    - Add .logtags
                    - proto to java
                    - java to class
                    - 定义make clean的具体任务
                    - Install 模块相关定义
                        - do dexpreopt
                    - Register with ALL_MODULES
                    - NOTICE file target
                - 定义中间模块产生的具体command

                    ```shell
                    $(full_classes_compiled_jar): $(java_sources) $(java_resource_sources) $(full_java_lib_deps) $(jar_manifest_file) $(RenderScript_file_stamp) $(proto_java_sources_file_stamp)
                       $(transform-java-to-classes.jar)
                    $(full_classes_jarjar_jar): $(full_classes_compiled_jar)
                       # 根据是否需要jarjar的不同采用不同的处理
                       # JARJAR
                    $(full_classes_emma_jar): $(full_classes_jarjar_jar)
                       # 根据是否需要emma的不同采用不同的处理
                       # EMMA
                    $(full_classes_jar): $(full_classes_emma_jar) | $(ACP)
                    $(full_classes_proguard_jar) : $(full_classes_jar) $(proguard_flag_files)
                        # PROGUARD
                    $(built_dex_intermediate): $(full_classes_proguard_jar) $(DX)
                        # DEX
                    $(built_dex): $(built_dex_intermediate) | $(ACP)
                    $(findbugs_xml) : $(LOCAL_BUILT_MODULE)
                    ```

            - 定义APP相关数据的生成

                ```shell
                $(R_file_stamp): $(all_res_assets) $(full_android_manifest) $(RenderScript_file_stamp) $(AAPT) | $(ACP)
                    # AAPT
                $(LOCAL_BUILT_MODULE): XXXXX
                    # PACKAGE
                    # signature
                    # zipalign
                ```

            - lintall : lint-$(LOCAL_PACKAGE_NAME)


# 开发者需要关注的API
## 可以使用的工具
1. SRC
    1. java
    2. RenderScript
    3. Proto
    4. AIDL
    5. jni
2. TOOLS
    1. EMMC测试覆盖工具
    2. jarjar Java包批处理工具
    3. Proguard 系统优化工具
    4. 系统级优化工具(需要以ROM的形式发布): preopt/odex
    5. lint bug分析工具
    6. signature
    7. zipalign
    8. findbugs 好像已经无法使用了

## 编译控制参数
目前我们主要关注APP相关的控制参数.

### 主要的API
- LOCAL_PACKAGE_NAME
- LOCAL_MODULE
- LOCAL_IS_HOST_MODULE
    - default value: false
- LOCAL_MODULE_CLASS
    - default value: APPS
- LOCAL_MODULE_TAGS
    - default value: optional
    - 可以是很多参数
        - debug eng tests optional samples shell\_ash shell\_mksh
    - 具体参数可能的影响
        - tests

            ```makefile
            LOCAL_AAPT_FLAGS := $(LOCAL_AAPT_FLAGS) -z
            ```

- Resources
    - LOCAL_MANIFEST_FILE
        - default value: AndroidManifest.xml
        - LOCAL\_PATH下用于指定MANIFEST
    - FULL_MANIFEST_FILE
        - default value: $(LOCAL_PATH)/$(LOCAL_MANIFEST_FILE)
        - 最终指定MANIFEST_FILE的地方
    - LOCAL_ASSET_DIR
        - default value: $(LOCAL_PATH)/assets
    - LOCAL_RESOURCE_DIR
        - default value: $(LOCAL_PATH)/res
            - add $(package_resource_overlays)
                - PRODUCT_PACKAGE_OVERLAYS
                - DEVICE_PACKAGE_OVERLAYS
        - 最后的整体结构是, 按先后编译应用的资源: 优先顺序是 PRODUCT, DEVICE, LOCAL
    - LOCAL_EXPORT_PACKAGE_RESOURCES
- EMMA
    - LOCAL_EMMA_INSTRUMENT
        - default value:
            - $(LOCAL_MODULE_TAGS))$(LOCAL_INSTRUMENTATION_FOR) contain tests => true
        - 会根据上下文自动添加emma的模块依赖
    - LOCAL_EMMA_COVERAGE_FILTER
- PROGUARD
    - LOCAL_PROGUARD_ENABLED
        - default value:
            - TARGET_BUILD_VARIANT contains user,userdebug=> full
        - value:
            - disabled: 关闭
            - custom
                - !=

                    ```makefile
                    proguard_options_file := $(package_expected_intermediates_COMMON)/proguard_options
                    ```

    - LOCAL_PROGUARD_FLAGS
        - 用于定义PROGUARD的相关参数
    - LOCAL_INSTRUMENTATION_FOR
- LOCAL_DEX_PREOPT
    - default value:
        - WITH_DEXPREOPT==true => true
- LOCAL_SRC_FILES
    - 源代码文件列表
    - .java
    - .aidl
    - MODULE_LICENSE*
    - .proto
    - .logtags
- LOCAL_JNI_SHARED_LIBRARIES
- LOCAL_CERTIFICATE
    - 签名
    - platform 等
- LOCAL_STATIC_JAVA_LIBRARIES
    - 静态依赖库, 最终会与应用一起打包
- LOCAL_JAVA_LIBRARIES
    - 动态依赖库
    - 会根据上下文添加SDK依赖, 系统模块依赖等
- RENDERSCRIPT
    - LOCAL_RENDERSCRIPT_TARGET_API
    - LOCAL_RENDERSCRIPT_CC
    - LOCAL_RENDERSCRIPT_FLAGS
    - LOCAL_RENDERSCRIPT_INCLUDES
    - LOCAL_RENDERSCRIPT_INCLUDES\_OVERRIDE: 会覆盖上述变量LOCAL_RENDERSCRIPT_INCLUDES

### HACK时使用的API
- LOCAL_MODULE_PATH
    - default value: system/app
    - 安装路径
- LOCAL_NO_STANDARD_LIBRARIES
- LOCAL_UNINSTALLABLE_MODULE
    - default value: false
    - 起作用后主要是通过如下操作完成

        ```makefile
        LOCAL_INSTALLED_MODULE := $(LOCAL_MODULE_PATH)/$(LOCAL_INSTALLED_MODULE_STEM)
        ```

- LOCAL_SDK_VERSION
- LOCAL_BUILT_MODULE_STEM
- LOCAL_INTERMEDIATE_TARGETS
    - 中间编译结果, 在添加新机制时可以使用. 一般*不要定义*.
- LOCAL_SOURCE_FILES_ALL_GENERATED
- LOCAL_PROPRIETARY_MODULE
    - 主要影响partition_tag
- LOCAL_MODULE_STEM
    - default value: LOCAL_MODULE
- LOCAL_MODULE_SUFFIX
    - default value: .apk
- LOCAL_AIDL_INCLUDES
- LOCAL_PROTOC_OPTIMIZE_TYPE
- LOCAL_JAVA_RESOURCE_DIRS
- LOCAL_JAR_MANIFEST
- LOCAL_AAPT_FLAGS
- findbugs.xml

# 分析后的感觉

不得不说, Makefile能够变成OO化的东西, 确实不容易.
整体编译系统中,我们可以看到Google在工程化上的强大, 将开发, 集成, 发布, 测试, 代码开源许可证等大量工程流程化的工作进行了一体化的封装与管理.

后续我准备按模块地将这些OO化的东西进行学习.
