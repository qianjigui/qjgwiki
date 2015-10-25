---
title: Go 语言在mobile上的开发
tags: Gomobile
---

# Android Go execute file的生成示例

在gomobile项目中, 可以通过简单的环境配置(go 1.5, gomobile)与gomobile build指令, 形成含有
`go-shared-library`的apk文件. 参见文档[Golang Mobile](https://github.com/golang/go/wiki/Mobile).

下列出现问题使用的gomobile版本: `gomobile version +ef84e05 Thu Sep 17 03:25:18 2015 +0000 (android); androidSDK=/android-sdk-linux/platforms/android-21`.
环境编译时的注意点:

* 无法下载gomobile包, 可能是本地机器无法访问golang.rog相关网络(例如GFW的限制). 可以通过具有访问权限的下载好, 然后在开发环境机上放置.

        GOPATH=$(pwd) go get golang.org/x/mobile/cmd/gomobile
        package golang.org/x/mobile/cmd/gomobile: unrecognized import path "golang.org/x/mobile/cmd/gomobile"

* `go init` 后移动目录, 发现无法编译. 如果移动了gomobile目录, 请重新go init进行环境设置. 主要是由于目前版本的gomobile依赖了大量外部绝对路径的资源: Android NDK等编译工具.

        # runtime/cgo
        Assembler messages:
        Fatal error: invalid -march= option: `armv5te'
        make: *** [xxxx] Error 2`

## 具体示例

代码结构与运行结果:

```
± % tree .
.
├── Makefile
├── bin
│   └── android_arm
│       └── example.com
└── src
    └── example.com
        └── main.go

4 directories, 3 files
± % adb root
± % adb push bin/android_arm/example.com /data/
± % adb shell
5486 KB/s (1955572 bytes in 0.348s)
root@maguro:/ # /data/
anr/            bugreports      jni/            property/       system/        
app-asec/       cloader         local/          radio/          tombstones/    
app-lib/        dalvik-cache/   lost+found/     rescue          user/          
app-private/    data/           main            resource-cache/ 
app/            dontpanic/      media/          security/       
armm            drm/            mediadrm/       smc/            
backup/         example.com     misc/           ssh/            
root@maguro:/ # /data/example.com                                              
2015/09/21 07:37:36 Hello Android!
root@maguro:/ # exit
```

源代码`src/example.com/main.go`:

```
package main

import (
	"log"
)

func main() {
	log.Println("Hello Android!")
}
```

编译脚本`Makefile`:

```
GOMOBILE:=$(HOME)/gomobile
GOMOBILE_NDK:=$(GOMOBILE)/pkg/gomobile/android-ndk-r10e/arm/bin

all:
	GOPATH=$(shell pwd) GOOS=android GOARCH=arm GOARM=7 CC=$(GOMOBILE_NDK)/arm-linux-androideabi-gcc CXX=$(GOMOBILE_NDK)/arm-linux-androideabi-g++ CGO_ENABLED=1 go install -a -pkgdir=$(GOMOBILE)/pkg_android_arm ./...
```

上述事例的关键部分:

1. 由`go init`时生成了Android系统使用的所有pkg包, 并下载了Android NDK相关交叉编译工具
2. 编译时, go 编译器需要指定 `GOOS, GOARCH, CGO_ENABLED, CC,CXX, -pkgdir` 关联工具与资源

## 其它方法

直接生成 `GOOS=linux GOARCH=arm` 的目标程序.
但网络中的`domain lookup`会出现问题.
