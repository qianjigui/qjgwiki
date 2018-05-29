---
title: Android AOSP 系统定制
tags: AOSP
---

## 具体Case

### 实时反馈目前系统是否在播放声音

主要介入修改点: `frameworks/av/services/audioflinger/Threads.cpp`

```
//播放线程准备时
AudioFlinger::PlaybackThread::mixer_state AudioFlinger::MixerThread::prepareTracks_l
//播放线程standby时
void AudioFlinger::MixerThread::threadLoop_standby()
```

### 系统广播乱发问题

### Valgrind不可使用的问题

* frameworks/base commit a32dbad

https://lark.alipay.com/pengcheng.wang/aosppatch/fix-valgrind-run

### 系统多层系统签名问题

### 第三方应用广播接收权限管理

### 安全管家相关功能

### 开机广播

#### Android 7.0相关流程

https://blog.csdn.net/petib_wangwei/article/details/70318057

添加log以增强广播流程分析

```
diff --git a/base/services/core/java/com/android/server/am/ActivityManagerDebugConfig.java b/base/services/core/java/com/android/ser
index 43bb5ee..0a55c3f 100644
--- a/base/services/core/java/com/android/server/am/ActivityManagerDebugConfig.java
+++ b/base/services/core/java/com/android/server/am/ActivityManagerDebugConfig.java
@@ -50,8 +50,8 @@ class ActivityManagerDebugConfig {
     static final boolean DEBUG_APP = DEBUG_ALL_ACTIVITIES || false;
     static final boolean DEBUG_BACKUP = DEBUG_ALL || false;
     static final boolean DEBUG_BROADCAST = DEBUG_ALL || false;
-    static final boolean DEBUG_BROADCAST_BACKGROUND = DEBUG_BROADCAST || false;
-    static final boolean DEBUG_BROADCAST_LIGHT = DEBUG_BROADCAST || false;
+    static final boolean DEBUG_BROADCAST_BACKGROUND = true;
+    static final boolean DEBUG_BROADCAST_LIGHT = true;
     static final boolean DEBUG_CLEANUP = DEBUG_ALL || false;
     static final boolean DEBUG_CONFIGURATION = DEBUG_ALL || false;
     static final boolean DEBUG_CONTAINERS = DEBUG_ALL_ACTIVITIES || false;
diff --git a/base/services/core/java/com/android/server/am/BroadcastQueue.java b/base/services/core/java/com/android/server/am/Broad
index f78f29c..cfa03e5 100644
--- a/base/services/core/java/com/android/server/am/BroadcastQueue.java
+++ b/base/services/core/java/com/android/server/am/BroadcastQueue.java
@@ -780,7 +780,7 @@ public final class BroadcastQueue {
                         + mQueueName + "] " + r);
                 for (int i=0; i<N; i++) {
                     Object target = r.receivers.get(i);
-                    if (DEBUG_BROADCAST)  Slog.v(TAG_BROADCAST,
+                    if (DEBUG_BROADCAST_LIGHT)  Slog.v(TAG_BROADCAST,
                             "Delivering non-ordered on [" + mQueueName + "] to registered "
                             + target + ": " + r);
                     deliverToRegisteredReceiverLocked(r, (BroadcastFilter)target, false, i);
```
