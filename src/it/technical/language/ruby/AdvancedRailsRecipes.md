---
title: "Reading Note for Advanced Rails Recipes"
tags: Rails
---

1  Introduction
   1.1 What Makes a Good Recipe Book?
   1.2 What Makes This an Advanced Recipe Book?
   1.3 Who’s It For?
   1.4 Who’s Talking?
   1.5 Rails Version
   1.6 Resources
   1.7 Acknowledgments
   1.8 Tags and Thumb tabs

Part I—REST and Routes Recipes
   1.     Putting A Resource On The Web
          利用REST提供WebAPI
   2.     Adding Your Own REST Actions (Or Not)
          添加自定义的REST
   3.     Authenticating REST Clients
          制作REST的session登录
   4.     Custom Response Formats
          自定义反馈信息格式
   5.     Catch All 404s
          捕获404错误: 做好记录工作;充分利用DB的index以提高速度

Part II—Search Recipes
   6.     Improve SEO with Dynamic Meta Tags
          通过Meta标签提高搜索引擎收录
   7.     Full-Text Search with Ferret
          利用Ferret实现DB全文搜索
   8.     Active Record on Solr
          利用solr实现全文搜索

Part III—Database Recipes
   9.     Adding Foreign Key Constraints
          添加外键关联
   10.    Write Your Own Custom Validations
          添加自定义表单验证
   11.    Analyzing SQL Queries
          分析优化SQL搜索
   12.    Taking Advantage of Master/Slave Databases
          利用主从数据库实现读写

Part IV—User Interface Recipes
   13.    Replacing In-View Raw JavaScript with RJS
          利用嵌入式的RJS替代原生态JavaScript
   14.    Handling Multiple Models In One Form
          单个表单中提交多个Model
   15.    Simplifying Controllers With a Presenter
          对于一个controller里面的多model处理:可以采用视图/混合类的方式进行处理,原理同14.另外需要充分利用method_missing, 利用人为的方式规定表单数据域格式
   16.    Validating Required Form Fields Inline
          即时表单验证
   17.    Creating a Wizard
          制作步骤导航
   18.    Updating Partial Resources with Ajax
          局部Ajax更新
   19.    Uploading Images and Creating Thumbnails
          Ajax上传图片
   20.    Decouple Your JavaScript with Low Pro
          简化javascript

Part V—Design Recipes
   21.    Freshening Up Your Models With Scope
          利用with scope简化Model 
   22.    Keeping Forms Dry and Flexible
          通过自定义的FormBuilder来DRY表单模板
   23.    Prevent Train Wrecks with Delegate
          利用委派机制将火车式的调用简单化
   24.    Creating Meaningful Relationships Through Proxies
          将Model间的关系语义化

Part VI—Asynchronous Recipes
   25.    Processing an Asynchronous Workflow
          处理异步工作流
   26.    Off-Loading Long-Running Tasks to BackgrounDRb
          将长时间任务处理放到后台

Part VII—E-mail Recipes
   27.    Validating E-mail Addresses
          验证Email格式
   28.    Receiving E-mail Reliably via POP or IMAP
          通过POP/IMAP收取邮件
   29.    Keeping E-mail Addresses Up To Date
          保证Email地址有效

Part VIII—Console Snacks
   30.    Writin’ Console Methods
          利用console
   31.    Console Loggin’
          Console日志
   32.    Playin’ in the Sandbox
          利用sandbox使console的操作最后对DB无效
   33.    Accessin’ Helpers
          利用Console查看helper效果
   34.    Shortcuttin’ the Console
          console快捷键

Part IX—Testing
   35.    Creating Your Own Rake Test Tasks
          创建自己的Rake 测试任务
   36.    Testing JavaScript With Selenium
          利用selenium测试JS
   37.    Mocking With a Safety Net
          在安全的网络里测试
   38.    Getting Started with BDD
          BDD
   39.    Describing Behaviour from the Outside-In With RSpec
          RSpec描述行为
   40.    Reducing Dependencies with Mocks
          消除Mock中的依赖
   41.    Fixtures Without Frustration
          测试数据有效
   42.    Tracking Test Coverage with RCov
          利用RCov检测测试覆盖率
   43.    Testing HTML Validity
          检测HTML合法性

Part X—Performance and Scalability Recipes
   44.    Looking Up Constant Data
          制作常量数据
   45.    Serving Page Caches to Facebook
          制作缓存
   46.    Profiling In The Browser
          在Browser中检测性能
   47.    Caching Up With the Big Guys
          追踪性能问题根源
   48.    Dynamically Updating Cached Pages
          动态更新Cache

Part XI—Security Recipes
   49.    Flipping On SSL
          利用SSL
   50.    Locking Down Sensitive Data
          控制敏感数据

Part XII—Deployment and Capistrano Recipes
   51.    Custom Maintenance Pages
   52.    Running Multi-Stage Deployments
   53.    Creating New Environments
   54.    Managing Plugin Versions
   55.    Safeguarding the Launch Codes
   56.    Config Files On-The-Fly
   57.    Preserving Files Between Deployments
   58.    Responding To Remote Prompts
   59.    Generating Custom Error Pages

Part XIII—Big-Picture Recipes
   60.    Avoid Starting From Scratch
   61.    Fail Early
   62.    Analyzing Your Log Files
   63.    Formatting Dates and Times
   64.    Geocoding to Find Things By Location
   65.    Giving Users Their Own Subdomain
   66.    Tunneling Back to Your Application
   67.    Monitoring (and Repairing) Processes with Monit

A Bibliography 288
  Index        289
