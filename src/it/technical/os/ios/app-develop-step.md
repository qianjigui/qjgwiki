---
title: iOS 应用开发整体流程
---

# 入库AppStore流程

[iPhone应用提交流程：如何将App程序发布到App Store？](http://blog.csdn.net/jwzbskywz/article/details/7730231)

# 常见问题处理

* [iOS9 & iOS10 & iOS11 HTTP 不能正常使用的解决办法](https://segmentfault.com/a/1190000002933776)
    * 常见错误提示: `Error copying matching creds.  Error=-25300`
* [iOS利用AVPlayer播放网络音乐的方法教程](https://m.jb51.net/article/114891.htm)
* [iOS socket异常会发生 SIGPIPE, 处理方案](https://blog.csdn.net/onlyou930/article/details/16116553)
    * 代码中处理: `signal(SIGPIPE, SIG_IGN);`
    * Xcode 调试中进行ignore: `process handle SIGPIPE -s false`
