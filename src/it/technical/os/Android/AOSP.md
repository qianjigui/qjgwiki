---
title: Android AOSP ROM开发
tags: Maguro AOSP
---

# Maguro Android 4.2.2

## download

```
mkdir aosp
cd aosp
repo init -u http://sssss -b android-4.2.2_r1.2
```

## Build 构建

[Ubuntu 18.04编译出错问题处理](https://blog.csdn.net/shui1025701856/article/details/80497911)

### 非AOSP部分代码合入

请根据版本与设备型号从[google官方](https://developers.google.com/android/nexus/drivers#magurojdq39)下载补丁.

如果没有合入这部分补丁, 就会导致系统无法启动等问题,
这是由于AOSP中没有包含一些非开源的代码部分.

例如maguro版本中, 就会出现如下问题:

```
*** *** *** *** *** *** *** *** *** *** *** *** *** *** *** ***
Build fingerprint: 'unknown'
Revision: '9'
pid: 1210, tid: 1212, name: SurfaceFlinger  >>> /system/bin/surfaceflinger <<<
signal 11 (SIGSEGV), code 1 (SEGV_MAPERR), fault addr deadbaad
    r0 00000027  r1 deadbaad  r2 40177258  r3 00000000
    r4 00000000  r5 40536d04  r6 00000000  r7 40ec09b0
    r8 00000002  r9 00003038  sl 00003142  fp 00003038
    ip 400d4ff4  sp 40536d00  lr 4014a0d9  pc 40146772  cpsr 60000030
    d0  5f4441425f4c4744  d1  646f697265702049
    d2  2064616f6c206f53  d3  62697461706d6f50
    d4  000000020000009e  d5  000000020000000d
    d6  0000000000000001  d7  426c8f5c00000000
    d8  0000000000000000  d9  0000000000000000
    d10 0000000000000000  d11 0000000000000000
    d12 0000000000000000  d13 0000000000000000
    d14 0000000000000000  d15 0000000000000000
    d16 4170202e598a1e04  d17 41cdcd6500000000
    d18 3d9262fffe000000  d19 3fe0000000000000
    d20 3fe0000000009318  d21 0000000000000000
    d22 0000000000000000  d23 0000000000000000
    d24 0000000000000000  d25 0000000000000000
    d26 0000000000000000  d27 0000000000000000
    d28 0000000000000000  d29 0000000000000000
    d30 0000000000000000  d31 0000000000000000
    scr 20000010

backtrace:
    #00  pc 0001a772  /system/lib/libc.so
    #01  pc 00018070  /system/lib/libc.so (abort+4)
    #02  pc 000008f1  /system/lib/libstdc++.so (operator new(unsigned int)+8)
    #03  pc 0002474d  /system/lib/libsurfaceflinger.so (android::SurfaceFlinger::selectConfigForAttribute(void*, int const*, int, int, void**)+38)
    #04  pc 000248a7  /system/lib/libsurfaceflinger.so (android::SurfaceFlinger::selectEGLConfig(void*, int)+162)
    #05  pc 00028819  /system/lib/libsurfaceflinger.so (android::SurfaceFlinger::readyToRun()+92)
    #06  pc 0001123d  /system/lib/libutils.so (android::Thread::_threadLoop(void*)+72)
    #07  pc 00010dcd  /system/lib/libutils.so
    #08  pc 0000e3d8  /system/lib/libc.so (__thread_entry+72)
    #09  pc 0000dac4  /system/lib/libc.so (pthread_create+160)

stack:
         40536cc0  c0000000  
         40536cc4  00000050  
         40536cc8  00000000  
         40536ccc  00000000  
         40536cd0  0000005b  
         40536cd4  34d8dbbd  
         40536cd8  40174254  /system/lib/libc.so
         40536cdc  401741b4  /system/lib/libc.so
         40536ce0  00000000  
         40536ce4  4014a0d9  /system/lib/libc.so (_fwalk+32)
         40536ce8  00000001  
         40536cec  40536d04  
         40536cf0  00000000  
         40536cf4  40ec09b0  [heap]
         40536cf8  df0027ad  
         40536cfc  00000000  
    #00  40536d00  00000000  
         40536d04  fffffbdf  
         40536d08  00000000  
         40536d0c  00000000  
         40536d10  40ec09b0  [heap]
         40536d14  00000002  
         40536d18  00003038  
         40536d1c  40536dc4  
         40536d20  00000000  
         40536d24  40144074  /system/lib/libc.so (__pthread_clone)
    #01  40536d28  00000000  
         40536d2c  400d38f5  /system/lib/libstdc++.so (operator new(unsigned int)+12)
    #02  40536d30  00000000  
         40536d34  4011b751  /system/lib/libsurfaceflinger.so (android::SurfaceFlinger::selectConfigForAttribute(void*, int const*, int, int, void**)+42)
    #03  40536d38  40536d68  
         40536d3c  40536dc4  
         40536d40  00000000  
         40536d44  ffffffff  
         40536d48  00000000  
         40536d4c  401ca41f  /system/lib/libutils.so (android::SortedVectorImpl::add(void const*)+30)
         40536d50  40536dc4  
         40536d54  40536dc4  
         40536d58  00003038  
         40536d5c  00000000  
         40536d60  40536d84  
         40536d64  00000002  
         40536d68  00003147  
         40536d6c  00003142  
         40536d70  00003024  
         40536d74  4011b8ab  /system/lib/libsurfaceflinger.so (android::SurfaceFlinger::selectEGLConfig(void*, int)+166)
    #04  40536d78  40536d84  
         40536d7c  00000000  
         40536d80  c0000030  
         40536d84  00000008  
         40536d88  00000000  
         40536d8c  40536dc4  
         40536d90  00003033  
         40536d94  40536dc4  
         40536d98  00003142  
         40536d9c  40536dc4  
         40536da0  00003147  
         40536da4  40536dc4  
         40536da8  00003024  
         40536dac  40536dc4  
         40536db0  00003023  
         40536db4  40536dc4  
         ........  ........
    #05  40536e00  40039480  /dev/__properties__ (deleted)
         40536e04  00000017  
         40536e08  0000000d  
         40536e0c  40159119  /system/lib/libc.so (__system_property_find+56)
         40536e10  40ec0318  [heap]
         40536e14  40536e50  
         40536e18  40536e50  
         40536e1c  401ce834  /system/lib/libutils.so
         40536e20  fffffff8  
         40536e24  401c8d35  /system/lib/libutils.so
         40536e28  00100000  
         40536e2c  40159179  /system/lib/libc.so (__system_property_get+8)
         40536e30  40536e50  
         40536e34  4019e455  /system/lib/libcutils.so (property_get+36)
         40536e38  40177228  
         40536e3c  401c8c05  /system/lib/libutils.so
         ........  ........
    #06  40536ea0  40ec032c  [heap]
         40536ea4  4013d813  /system/lib/libc.so (dlfree+34)
         40536ea8  40ec032c  [heap]
         40536eac  40ec0530  [heap]
         40536eb0  40ec032c  [heap]
         40536eb4  40ec0618  [heap]
         40536eb8  401c91f5  /system/lib/libutils.so (android::Thread::_threadLoop(void*))
         40536ebc  40ec032c  [heap]
         40536ec0  00000000  
         40536ec4  401c8dcf  /system/lib/libutils.so
    #07  40536ec8  00000000  
         40536ecc  40ec0630  [heap]
         40536ed0  40536ffc  
         40536ed4  40536f00  
         40536ed8  40ec0630  [heap]
         40536edc  401c8d35  /system/lib/libutils.so
         40536ee0  40ec0600  [heap]
         40536ee4  4013a3dc  /system/lib/libc.so (__thread_entry+76)
    #08  40536ee8  40ec0600  [heap]
         40536eec  40536f00  
         40536ef0  be836ae0  [stack]
         40536ef4  40ec0630  [heap]
         40536ef8  00000078  
         40536efc  40139ac8  /system/lib/libc.so (pthread_create+164)
    #09  40536f00  40536f00  
         40536f04  40ec0630  [heap]
         40536f08  0000000c  
         40536f0c  00000000  
         40536f10  00000000  
         40536f14  00000000  
         40536f18  00000000  
         40536f1c  40ec0610  [heap]
         40536f20  00000000  
         40536f24  00000000  
         40536f28  00000000  
         40536f2c  00000000  
         40536f30  00000000  
         40536f34  00000000  
         40536f38  00000000  
         40536f3c  00000000  

memory near r2:
    40177238 00000000 00000000 00000000 00000000  
    40177248 00000000 00000000 00000000 00000000  
    40177258 00000001 00000000 00000000 00000000  
    40177268 00000000 00000000 00000000 00000000  
    40177278 00000000 00000000 00000000 00000000  
    40177288 00000000 00000000 00000000 00000000  
    40177298 00000000 00000000 08f4742a 00000000  
    401772a8 00000000 00000000 00000000 00000000  
    401772b8 00000000 00000000 00000000 00000000  
    401772c8 00000000 00000000 00000000 00000000  
    401772d8 00000000 00000000 00000000 00000000  
    401772e8 00000000 00000000 00000000 00000000  
    401772f8 00000000 00000000 00000000 00004000  
    40177308 00000000 00000000 00000000 00004000  
    40177318 00000000 00000000 00000000 00004000  
    40177328 00000000 00000000 00000000 00004000  

memory near r5:
    40536ce4 4014a0d9 00000001 40536d04 00000000  
    40536cf4 40ec09b0 df0027ad 00000000 00000000  
    40536d04 fffffbdf 00000000 00000000 40ec09b0  
    40536d14 00000002 00003038 40536dc4 00000000  
    40536d24 40144074 00000000 400d38f5 00000000  
    40536d34 4011b751 40536d68 40536dc4 00000000  
    40536d44 ffffffff 00000000 401ca41f 40536dc4  
    40536d54 40536dc4 00003038 00000000 40536d84  
    40536d64 00000002 00003147 00003142 00003024  
    40536d74 4011b8ab 40536d84 00000000 c0000030  
    40536d84 00000008 00000000 40536dc4 00003033  
    40536d94 40536dc4 00003142 40536dc4 00003147  
    40536da4 40536dc4 00003024 40536dc4 00003023  
    40536db4 40536dc4 00003022 00003038 00003038  
    40536dc4 40128ff8 40ec09b0 00000007 00000000  
    40536dd4 00000008 40129654 40ec0318 40122d78  

memory near r7:
    40ec0990 00003038 00003038 00000038 0000005a  
    40ec09a0 00000001 00000040 00000000 00000000  
    40ec09b0 00003022 00000008 00003023 00000008  
    40ec09c0 00003024 00000008 00003033 00000004  
    40ec09d0 00003142 00000001 00003147 00000001  
    40ec09e0 00003038 00003038 00000000 00000000  
    40ec09f0 00000000 00000c81 00000000 00000000  
    40ec0a00 00000000 00000000 00000000 00000000  
    40ec0a10 00000000 00000000 00000000 00000000  
    40ec0a20 00000000 00000000 00000000 00000000  
    40ec0a30 00000000 00000000 00000000 00000000  
    40ec0a40 00000000 00000000 00000000 00000000  
    40ec0a50 00000000 00000000 00000000 00000000  
    40ec0a60 00000000 00000000 00000000 00000000  
    40ec0a70 00000000 00000000 00000000 00000000  
    40ec0a80 00000000 00000000 00000000 00000000  

memory near r9:
    00003018 ffffffff ffffffff ffffffff ffffffff  
    00003028 ffffffff ffffffff ffffffff ffffffff  
    00003038 ffffffff ffffffff ffffffff ffffffff  
    00003048 ffffffff ffffffff ffffffff ffffffff  
    00003058 ffffffff ffffffff ffffffff ffffffff  
    00003068 ffffffff ffffffff ffffffff ffffffff  
    00003078 ffffffff ffffffff ffffffff ffffffff  
    00003088 ffffffff ffffffff ffffffff ffffffff  
    00003098 ffffffff ffffffff ffffffff ffffffff  
    000030a8 ffffffff ffffffff ffffffff ffffffff  
    000030b8 ffffffff ffffffff ffffffff ffffffff  
    000030c8 ffffffff ffffffff ffffffff ffffffff  
    000030d8 ffffffff ffffffff ffffffff ffffffff  
    000030e8 ffffffff ffffffff ffffffff ffffffff  
    000030f8 ffffffff ffffffff ffffffff ffffffff  
    00003108 ffffffff ffffffff ffffffff ffffffff  

memory near sl:
    00003120 ffffffff ffffffff ffffffff ffffffff  
    00003130 ffffffff ffffffff ffffffff ffffffff  
    00003140 ffffffff ffffffff ffffffff ffffffff  
    00003150 ffffffff ffffffff ffffffff ffffffff  
    00003160 ffffffff ffffffff ffffffff ffffffff  
    00003170 ffffffff ffffffff ffffffff ffffffff  
    00003180 ffffffff ffffffff ffffffff ffffffff  
    00003190 ffffffff ffffffff ffffffff ffffffff  
    000031a0 ffffffff ffffffff ffffffff ffffffff  
    000031b0 ffffffff ffffffff ffffffff ffffffff  
    000031c0 ffffffff ffffffff ffffffff ffffffff  
    000031d0 ffffffff ffffffff ffffffff ffffffff  
    000031e0 ffffffff ffffffff ffffffff ffffffff  
    000031f0 ffffffff ffffffff ffffffff ffffffff  
    00003200 ffffffff ffffffff ffffffff ffffffff  
    00003210 ffffffff ffffffff ffffffff ffffffff  

memory near fp:
    00003018 ffffffff ffffffff ffffffff ffffffff  
    00003028 ffffffff ffffffff ffffffff ffffffff  
    00003038 ffffffff ffffffff ffffffff ffffffff  
    00003048 ffffffff ffffffff ffffffff ffffffff  
    00003058 ffffffff ffffffff ffffffff ffffffff  
    00003068 ffffffff ffffffff ffffffff ffffffff  
    00003078 ffffffff ffffffff ffffffff ffffffff  
    00003088 ffffffff ffffffff ffffffff ffffffff  
    00003098 ffffffff ffffffff ffffffff ffffffff  
    000030a8 ffffffff ffffffff ffffffff ffffffff  
    000030b8 ffffffff ffffffff ffffffff ffffffff  
    000030c8 ffffffff ffffffff ffffffff ffffffff  
    000030d8 ffffffff ffffffff ffffffff ffffffff  
    000030e8 ffffffff ffffffff ffffffff ffffffff  
    000030f8 ffffffff ffffffff ffffffff ffffffff  
    00003108 ffffffff ffffffff ffffffff ffffffff  

memory near ip:
    400d4fd4 00000000 00000000 00000000 4014d761  
    400d4fe4 4014d651 40144110 40144130 40138ef5  
    400d4ff4 4014406c 40138f09 4014d605 400d5000  
    400d5004 00000000 00000000 00000000 00000000  
    400d5014 00000000 00000000 00000000 00000000  
    400d5024 00000000 00000000 00000000 00000000  
    400d5034 00000000 00000000 00000000 00000000  
    400d5044 00000000 00000000 00000000 00000000  
    400d5054 00000000 00000000 00000000 00000000  
    400d5064 00000000 00000000 00000000 00000000  
    400d5074 00000000 00000000 00000000 00000000  
    400d5084 00000000 00000000 00000000 00000000  
    400d5094 00000000 00000000 00000000 00000000  
    400d50a4 00000000 00000000 00000000 00000000  
    400d50b4 00000000 00000000 00000000 00000000  
    400d50c4 00000000 00000000 00000000 00000000  

memory near sp:
    40536ce0 00000000 4014a0d9 00000001 40536d04  
    40536cf0 00000000 40ec09b0 df0027ad 00000000  
    40536d00 00000000 fffffbdf 00000000 00000000  
    40536d10 40ec09b0 00000002 00003038 40536dc4  
    40536d20 00000000 40144074 00000000 400d38f5  
    40536d30 00000000 4011b751 40536d68 40536dc4  
    40536d40 00000000 ffffffff 00000000 401ca41f  
    40536d50 40536dc4 40536dc4 00003038 00000000  
    40536d60 40536d84 00000002 00003147 00003142  
    40536d70 00003024 4011b8ab 40536d84 00000000  
    40536d80 c0000030 00000008 00000000 40536dc4  
    40536d90 00003033 40536dc4 00003142 40536dc4  
    40536da0 00003147 40536dc4 00003024 40536dc4  
    40536db0 00003023 40536dc4 00003022 00003038  
    40536dc0 00003038 40128ff8 40ec09b0 00000007  
    40536dd0 00000000 00000008 40129654 40ec0318  

code around pc:
    40146750 e000b164 6823461c d1fb2b00 68e3e026  
    40146760 4a17b123 447a2401 47986014 20274911  
    40146770 70082400 eb86f7fc f7fd2106 a902ecea  
    40146780 f04f2006 460a5380 94029304 f7fd9403  
    40146790 4629e8d0 20024622 e8d8f7fd eb72f7fc  
    401467a0 f7fd2106 2001ecd6 e892f7fc 2a006962  
    401467b0 e7d4d1dc deadbaad 0002d826 00030b0a  
    401467c0 00030aee 2400b510 aa04b088 46699002  
    401467d0 94014620 94039400 e830f7fd bfb842a0  
    401467e0 db054620 b1139b07 1c489906 98069006  
    401467f0 bd10b008 4604b510 e9c6f7fc d10542a0  
    40146800 447b4b04 6018681b bd102000 30fff04f  
    40146810 bf00bd10 0002d75a 460db538 481eb928  
    40146820 f7fc4478 2800edc4 b9fdd130 2102481b  
    40146830 f0014478 2800faae db274604 f7fc4629  
    40146840 2800ec4e 2101db0b f7fc4620 2800ec48  

code around lr:
    4014a0b8 41f0e92d 4c0b2600 447c4680 68a56824  
    4014a0c8 e0076867 300cf9b5 dd022b00 47c04628  
    4014a0d8 35544306 d5f53f01 2c006824 4630d1ef  
    4014a0e8 81f0e8bd 00029ec2 43f0e92d fb01461f  
    4014a0f8 f8dff602 b0878058 44f8460c 8000f8d8  
    4014a108 9001a901 f8d84615 20013000 96059602  
    4014a118 90049103 4638b113 fa35f7ff a9034638  
    4014a128 fe9bf7ff 2000f8d8 b1124681 f7ff4638  
    4014a138 f1b9fa37 d0050f00 46219d05 f01a1b70  
    4014a148 4605ed46 b0074628 83f0e8bd 00029e3a  
    4014a158 1e4b6841 2b006043 f000da01 6803bbab  
    4014a168 2b01f813 46106003 00004770 4604b570  
    4014a178 447e4e0d 68336836 f7ffb10b 6861fa04  
    4014a188 60601e48 bfa22800 f8106820 60205b01  
    4014a198 4620da03 fb8ef000 68324605 4620b112  
    4014a1a8 f9fef7ff bd704628 00029dc2 447b4b07  

memory map around fault addr deadbaad:
    be816000-be837000 [stack]
    (no map for address)
    ffff0000-ffff1000 [vectors]
--------- tail end of log /dev/log/main
10-31 06:40:49.320  1210  1212 E ti_hwc  : Composer HAL failed to load compatible Graphics HAL
10-31 06:40:49.320  1210  1212 E SurfaceFlinger: composer device failed to initialize (Invalid argument)
10-31 06:40:49.320  1210  1212 W SurfaceFlinger: getting VSYNC period from fb HAL: 16909029
10-31 06:40:49.320  1210  1212 E libEGL  : validate_display:251 error 3008 (EGL_BAD_DISPLAY)
10-31 06:40:49.320  1210  1212 F libc    : Fatal signal 11 (SIGSEGV) at 0xdeadbaad (code=1), thread 1212 (SurfaceFlinger)
--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
pid: 1210, tid: 1210, name: surfaceflinger
    r0 40ec04f8  r1 00000080  r2 00000000  r3 00000000
    r4 40ec04f8  r5 40ec04f4  r6 00000000  r7 000000f0
    r8 40ec0318  r9 00000000  sl 00000000  fp be836bcc
    ip 00000000  sp be836af8  lr 4013a420  pc 40144104  cpsr 60000010
    d0  466563616672756c  d1  0000000040ebe869
    d2  40ebdcd040ebdc6e  d3  40ebdcf040ebdc67
    d4  40ebd38040ebd370  d5  40ebd3a040ebd390
    d6  40ebd80040ebd3b0  d7  40ebdc6040ebdc50
    d8  0000000000000000  d9  0000000000000000
    d10 0000000000000000  d11 0000000000000000
    d12 0000000000000000  d13 0000000000000000
    d14 0000000000000000  d15 0000000000000000
    d16 41a1e8e85578d4fe  d17 3f50624dd2f1a9fc
    d18 41ac66d5e0000000  d19 0000000000000000
    d20 0000000000000000  d21 0000000000000000
    d22 0000000000000000  d23 0000000000000000
    d24 0000000000000000  d25 0000000000000000
    d26 0000000000000000  d27 0000000000000000
    d28 0000000000000000  d29 0000000000000000
    d30 0000000000000000  d31 0000000000000000
    scr 00000010

backtrace:
    #00  pc 00018104  /system/lib/libc.so (__futex_syscall3+8)
    #01  pc 0000e41c  /system/lib/libc.so (__pthread_cond_timedwait_relative+48)
    #02  pc 0000e478  /system/lib/libc.so (__pthread_cond_timedwait+60)
    #03  pc 00024633  /system/lib/libsurfaceflinger.so
    #04  pc 0002674d  /system/lib/libsurfaceflinger.so (android::SurfaceFlinger::onFirstRef()+52)
    #05  pc 0000ef2d  /system/lib/libutils.so (android::RefBase::incStrong(void const*) const+38)
    #06  pc 000007d7  /system/bin/surfaceflinger
    #07  pc 00000845  /system/bin/surfaceflinger
    #08  pc 0001271f  /system/lib/libc.so (__libc_init+38)
    #09  pc 00000724  /system/bin/surfaceflinger

stack:
         be836ab8  00000000  
         be836abc  40139154  /system/lib/libc.so (pthread_attr_destroy+16)
         be836ac0  40536f00  
         be836ac4  401c8cf3  /system/lib/libutils.so (androidCreateRawThreadEtc+138)
         be836ac8  c0000000  
         be836acc  00000010  
         be836ad0  40ec05d0  [heap]
         be836ad4  00000000  
         be836ad8  0000001b  
         be836adc  40ec0630  [heap]
         be836ae0  42424242  
         be836ae4  42424242  
         be836ae8  42424242  
         be836aec  42424242  
         be836af0  42424242  
         be836af4  42424242  
    #00  be836af8  40ec04f8  [heap]
         be836afc  00000000  
    #01  be836b00  00000000  
         be836b04  40ec04f4  [heap]
         be836b08  40ec04f8  [heap]
         be836b0c  00000001  
         be836b10  40ec02a8  [heap]
         be836b14  4013a47c  /system/lib/libc.so (__pthread_cond_timedwait+64)
    #02  be836b18  401c9135  /system/lib/libutils.so (android::Thread::run(char const*, int, unsigned int))
         be836b1c  00000001  
         be836b20  40ec02a8  [heap]
         be836b24  40ec04f4  [heap]
         be836b28  40ec04f8  [heap]
         be836b2c  4011b637  /system/lib/libsurfaceflinger.so
    #03  be836b30  40ec04f4  [heap]
         be836b34  40ec04f4  [heap]
         be836b38  40ec0334  [heap]
         be836b3c  40ec0318  [heap]
         be836b40  401c9135  /system/lib/libutils.so (android::Thread::run(char const*, int, unsigned int))
         be836b44  4011d751  /system/lib/libsurfaceflinger.so (android::SurfaceFlinger::onFirstRef()+56)
    #04  be836b48  40ec0318  [heap]
         be836b4c  40ec0318  [heap]
         be836b50  00000000  
         be836b54  40ec0530  [heap]
         be836b58  402f4ab5  /system/lib/libbinder.so
         be836b5c  401c6f2f  /system/lib/libutils.so (android::RefBase::incStrong(void const*) const+40)
    #05  be836b60  be836b70  [stack]
         be836b64  400737db  /system/bin/surfaceflinger
    #06  be836b68  40ec02a8  [heap]
         be836b6c  40ec02f0  [heap]
         be836b70  40ec031c  [heap]
         be836b74  00000000  
         be836b78  40073841  /system/bin/surfaceflinger
         be836b7c  be836bd4  [stack]
         be836b80  00000001  
         be836b84  be836bdc  [stack]
         be836b88  00000000  
         be836b8c  40073849  /system/bin/surfaceflinger
    #07  be836b90  00000001  
         be836b94  be836bd4  [stack]
         be836b98  be836bdc  [stack]
         be836b9c  4013e721  /system/lib/libc.so (__libc_init+40)
    #08  be836ba0  be836bb8  [stack]
         be836ba4  00000000  
         be836ba8  00000000  
         be836bac  00000000  
         be836bb0  00000000  
         be836bb4  40073728  /system/bin/surfaceflinger
    #09  be836bb8  40074e7c  /system/bin/surfaceflinger
         be836bbc  40074e84  /system/bin/surfaceflinger
         be836bc0  40074e8c  /system/bin/surfaceflinger
         be836bc4  be836bd0  [stack]
         be836bc8  00000000  
         be836bcc  400dfbbb  /system/bin/linker
         be836bd0  00000001  
         be836bd4  be836cc8  [stack]
         be836bd8  00000000  
         be836bdc  be836ce3  [stack]
         be836be0  be836d20  [stack]
         be836be4  be836d48  [stack]
         be836be8  be836d5b  [stack]
         be836bec  be836d70  [stack]
         be836bf0  be836d8b  [stack]
         be836bf4  be836d9e  [stack]
--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
pid: 1210, tid: 1213, name: VSyncThread
    r0 40ec08cc  r1 00000080  r2 00000000  r3 00000000
    r4 40ec08cc  r5 40ec08c8  r6 00000000  r7 000000f0
    r8 401c8d35  r9 00100000  sl 40ec0910  fp 00000000
    ip 00000000  sp 40d8be30  lr 4013a420  pc 40144104  cpsr 60000010
    d0  726854636e795365  d1  646f697265702061
    d2  2064616f6c206f64  d3  62697461706d6f00
    d4  000000020000009e  d5  000000020000000d
    d6  0000000000000001  d7  426c8f5c00000000
    d8  0000000000000000  d9  0000000000000000
    d10 0000000000000000  d11 0000000000000000
    d12 0000000000000000  d13 0000000000000000
    d14 0000000000000000  d15 0000000000000000
    d16 4170202e598a1e04  d17 41cdcd6500000000
    d18 3d9262fffe000000  d19 3fe0000000000000
    d20 3fe0000000009318  d21 0000000000000000
    d22 0000000000000000  d23 0000000000000000
    d24 0000000000000000  d25 0000000000000000
    d26 0000000000000000  d27 0000000000000000
    d28 0000000000000000  d29 0000000000000000
    d30 0000000000000000  d31 0000000000000000
    scr 20000010

backtrace:
    #00  pc 00018104  /system/lib/libc.so (__futex_syscall3+8)
    #01  pc 0000e41c  /system/lib/libc.so (__pthread_cond_timedwait_relative+48)
    #02  pc 0000e478  /system/lib/libc.so (__pthread_cond_timedwait+60)
    #03  pc 00022131  /system/lib/libsurfaceflinger.so (android::HWComposer::VSyncThread::threadLoop()+32)
    #04  pc 00011267  /system/lib/libutils.so (android::Thread::_threadLoop(void*)+114)
    #05  pc 00010dcd  /system/lib/libutils.so
    #06  pc 0000e3d8  /system/lib/libc.so (__thread_entry+72)
    #07  pc 0000dac4  /system/lib/libc.so (pthread_create+160)

stack:
         40d8bdf0  00000000  
         40d8bdf4  00000000  
         40d8bdf8  00000000  
         40d8bdfc  00000000  
         40d8be00  00000000  
         40d8be04  00000000  
         40d8be08  00000000  
         40d8be0c  00000000  
         40d8be10  00000000  
         40d8be14  00000000  
         40d8be18  00000000  
         40d8be1c  00000000  
         40d8be20  00000000  
         40d8be24  00000000  
         40d8be28  00000000  
         40d8be2c  00000000  
    #00  40d8be30  40ec08cc  [heap]
         40d8be34  00000000  
    #01  40d8be38  00000000  
         40d8be3c  40ec08c8  [heap]
         40d8be40  40ec08cc  [heap]
         40d8be44  40ec08c8  [heap]
         40d8be48  40ec08cc  [heap]
         40d8be4c  4013a47c  /system/lib/libc.so (__pthread_cond_timedwait+64)
    #02  40d8be50  401c4ead  /system/lib/libutils.so (android::BlobCache::getFdCount() const)
         40d8be54  40ec08a0  [heap]
         40d8be58  40ec08c8  [heap]
         40d8be5c  40ec08a0  [heap]
         40d8be60  40ec08c8  [heap]
         40d8be64  40119135  /system/lib/libsurfaceflinger.so (android::HWComposer::VSyncThread::threadLoop()+36)
    #03  40d8be68  00000000  
         40d8be6c  00000000  
         40d8be70  40177228  
         40d8be74  00000000  
         40d8be78  00000000  
         40d8be7c  00000000  
         40d8be80  00000000  
         40d8be84  00000000  
         40d8be88  00000000  
         40d8be8c  40ec08a0  [heap]
         40d8be90  40d8bea0  
         40d8be94  40128a6c  /system/lib/libsurfaceflinger.so
         40d8be98  40128a6c  /system/lib/libsurfaceflinger.so
         40d8be9c  401c9269  /system/lib/libutils.so (android::Thread::_threadLoop(void*)+116)
    #04  40d8bea0  40ec08a0  [heap]
         40d8bea4  4013d813  /system/lib/libc.so (dlfree+34)
         40d8bea8  40ec08a0  [heap]
         40d8beac  40ec08f8  [heap]
         40d8beb0  40ec08a0  [heap]
         40d8beb4  40ec0620  [heap]
         40d8beb8  401c91f5  /system/lib/libutils.so (android::Thread::_threadLoop(void*))
         40d8bebc  40ec08a0  [heap]
         40d8bec0  00000000  
         40d8bec4  401c8dcf  /system/lib/libutils.so
    #05  40d8bec8  00000000  
         40d8becc  40ec0928  [heap]
         40d8bed0  40d8bffc  
         40d8bed4  40d8bf00  
         40d8bed8  40ec0928  [heap]
         40d8bedc  401c8d35  /system/lib/libutils.so
         40d8bee0  40ec0910  [heap]
         40d8bee4  4013a3dc  /system/lib/libc.so (__thread_entry+76)
    #06  40d8bee8  40ec0910  [heap]
         40d8beec  40d8bf00  
         40d8bef0  40536cf0  
         40d8bef4  40ec0928  [heap]
         40d8bef8  00000078  
         40d8befc  40139ac8  /system/lib/libc.so (pthread_create+164)
    #07  40d8bf00  40d8bf00  
         40d8bf04  40ec0928  [heap]
         40d8bf08  00000000  
         40d8bf0c  00000000  
         40d8bf10  00000000  
         40d8bf14  00000000  
         40d8bf18  00000000  
         40d8bf1c  00000000  
         40d8bf20  00000000  
         40d8bf24  00000000  
         40d8bf28  00000000  
         40d8bf2c  00000000  
         40d8bf30  00000000  
         40d8bf34  00000000  
         40d8bf38  00000000  
         40d8bf3c  00000000  
--------- log /dev/log/main
10-31 06:40:49.304  1210  1210 I SurfaceFlinger: SurfaceFlinger is starting
10-31 06:40:49.304  1210  1212 I SurfaceFlinger: SurfaceFlinger's main thread ready to run. Initializing graphics H/W...
10-31 06:40:49.304  1210  1212 E libEGL  : eglGetDisplay:121 error 300c (EGL_BAD_PARAMETER)
10-31 06:40:49.304  1210  1212 E libEGL  : eglInitialize:137 error 3008 (EGL_BAD_DISPLAY)
10-31 06:40:49.312  1210  1212 I gralloc : using (fd=14)
id           = omapfb
xres         = 720 px
yres         = 1280 px
xres_virtual = 720 px
yres_virtual = 2560 px
bpp          = 32
r            = 16:8
g            =  8:8
b            =  0:8
10-31 06:40:49.312  1210  1212 I gralloc : width        = 58 mm (315.310333 dpi)
height       = 102 mm (318.745087 dpi)
refresh rate = 59.14 Hz
10-31 06:40:49.320  1210  1212 E ti_hwc  : Composer HAL failed to load compatible Graphics HAL
10-31 06:40:49.320  1210  1212 E SurfaceFlinger: composer device failed to initialize (Invalid argument)
10-31 06:40:49.320  1210  1212 W SurfaceFlinger: getting VSYNC period from fb HAL: 16909029
10-31 06:40:49.320  1210  1212 E libEGL  : validate_display:251 error 3008 (EGL_BAD_DISPLAY)
10-31 06:40:49.320  1210  1212 F libc    : Fatal signal 11 (SIGSEGV) at 0xdeadbaad (code=1), thread 1212 (SurfaceFlinger)
```


