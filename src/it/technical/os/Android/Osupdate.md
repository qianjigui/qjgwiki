
---
title: Android 升级主要关注点
tags: AOSP Update
---

升级涉及系统升级与应用升级

#### 常见策略

* 分片下降
* 出错记录

#### 常见错误

* 网络问题
    * NETWORK_ERROR      
    * NETWORK_IO_ERROR    
    * NETWORK_NOT_AVAILABLE 
    * NETWORK_TIMEOUT      
* 数据包问题
    * DOWNLOAD_ERROR  
    * FILE_NOT_FOUND  
    * FOTA_VERIFY_FAIL 
    * MD5_ERROR         
* 本地存储空间问题
    * SPACE_NOT_ENOUGH      
    * STORAGE_ERROR      
    * CACHE_SPACE_NOT_ENOUGH
    * DATA_SPACE_NOT_ENOUGH
* 系统权限问题
    * PERMISSION_DENY  
* 升级本身问题
    * APP_UPGRADE_FAIL 
    * FOTA_UPGRADE_FAIL 

#### 兼容性问题

* 升级引导
* 数据存储区索引
