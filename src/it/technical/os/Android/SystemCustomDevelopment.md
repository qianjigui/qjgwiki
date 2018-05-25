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

### 系统多层系统签名问题

### 第三方应用广播接收权限管理

### 安全管家相关功能

