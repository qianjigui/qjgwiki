---
title: "Reading Note for Rails Recipes"
tags: Rails
---

对于目录的翻译整理，方便以后查阅。

# Introduction
1. What Makes a Good Recipe Book?
2. Who’s It For?
3. Rails Version
4. Resources
5. Acknowledgments
6. Tags and Thumbtabs

# Part I—User Interface Recipes
1.     In-Place Form Editing
       原地Ajax表单编辑
2.     Making Your Own JavaScript Helper
       制作方便自己使用的JS生成方法
3.     Live Preview
       实时编辑查看结果显示
4.     Live Search
       实时搜索结果显示
5.     Creating a Drag-and-Drop Sortable List
       创建可以拖动的排序列表
6.     Update Multiple Page Elements With One Ajax Request
       通过一个Ajax请求更新多个页面的元素
7.     Lightning-Fast JavaScript Auto-completion
       快速的JS自动补全
8.     Cheap and Easy Theme Support
       页面主题变更支持
9.     Use Ajax To Trim Fat, Static Pages
       利用Ajax修剪复杂的页面
10.    Smart Pluralization
       通过工具实现I18N
11.    Debugging Ajax
       调试Ajax
12.    Creating a Custom Form Builder
       自定义表单生成
13.    Make Pretty Graphs
       生成漂亮的图像

# Part II—Database Recipes
14.    Rails Without A Database
       不用DB
15.    Connecting to Multiple Databases
       同时连接使用过个DB
16.    Integrating with Legacy Databases
       集成废弃的DB
17.    DRY Up Your Database Configuration
       做通用的DB配置
18.    Self-referential Many-to-Many Relationships
       Model自身的多对多关系实现
19.    Tagging
       文本数据打Tag
20.    Versioning Your ActiveRecord Models
       版本控制用户编辑的数据Model(类似于草稿)
21.    Convert an Existing Application to Migrations
       对存在的应用做迁移
22.    Many to Many Relationships Where the Relationship Itself Has Data
       多对多关系中，关系表中存在私有数据
23.    Polymorphic Associations - has_many :whatevers
       一对多关系中同时对应多个Model
24.    Adding Behavior to Your ActiveRecord Associations
       在关联中添加行为，方便在关联获取时添加搜索条件约束
25.    Dynamic Database Config
       动态DB配置:类似于ERB
26.    Use ActiveRecord Outside of Rails
       将ActiveRecord模型抽取出来单独使用
27.    Perform Calculations on Yor Model Data
       检测Model的性能
28.    DRY Up Your ActiveRecord Code With Scoping
       使Scoping不重复
29.    Make Dumb Data Smart with composed_of
       将一个复杂的对象映射到DB表中的一个表项
30.    Safely Use Models in Migrations
       在Model迁移中注意一致性

# Part III—Controller Recipes
31.    Authentication
       验证
32.    Role-Based Authorization
       基于规则的验证
33.    Cleaning Up Controllers with Postback Actions
       去掉冗余的action
34.    Keep An Eye On Your Session Expiry
       注意session有效期
35.    Rendering Comma Separated Values From Your Actions
       将返回数据格式化:Json, xml, cvs
36.    Make your URLs Meaningful (and pretty)
       使URL有意义
37.    Stub Out Authentication
       将验证作为过滤器的一部分
38.    Convert Your Sessions To ActiveRecord
       将session放入DB
39.    Write Code That Writes Code
       制作代码生成器
40.    Manage a Static Site With Rails
       利用Rails管理静态网站

# Part IV—Testing Recipes
41.    Creating Dynamic Test Fixtures
       制作动态测试数据
42.    Extracting Test Fixtures From Live Data
       从实际数据中抽取测试数据
43.    Testing Across Multiple Controllers
       测试多请求访问
44.    Write Tests for Your Helpers
       为辅助方法做测试

# Part V—Big Picture Recipes
45.    Automating Development With Your Own Generators
       制作自己的生成器
46.    Continuous Integration
       持续集成
47.    Getting Notified of Unhandled Exceptions
       捕获异常
48.    Creating Your Own Rake Tasks
       制作自己的Rake任务
49.    Dealing With Time-zones
       解决时区问题
50.    Living On The Edge (of Rails Development)
       跟紧各种更新
51.    Syndicate Your Site With RSS
       将数据RSS化
52.    Making Your Own Rails Plugins
       制作自己的插件
53.    Secret URLs
       带有验证信息的URL,需要在URL携带身份信息的处理方法
54.    Quickly Inspect Your Sessions’ Contents
       访问本地的session保护
55.    Sharing Models Between Your Applications
       通过链接等方式共享Model
56.    Generate Documentation For Your Application
       利用Rdoc
57.    Processing Uploaded Images
       处理上传的图片
58.    Easily Group Lists of Things
       对List做处理的API
59.    Keeping Track of Who Did What
       对信息做标注，记录操作用户
60.    Distributing Your Application As One Directory Tree
       利用目录树机制实现应用的分布式
61.    Adding Support for Localization
       L10N
62.    The Console Is Your Friend
       充分利用Console
63.    Automatically Save a Draft of a Form
       自动表单保存
64.    Validating Non-ActiveRecord Objects
       对非ActiveRecord对象做验证
65.    Easy HTML Whitelists
       对HTML敏感字符做过滤
66.    Adding Simple Web Services To Your Actions
       添加WebServices到Action

# Part VI—E-Mail Recipes
67.    Send Gracefully Degrading Rich-Content Emails
       发送富文本邮件(例如颜色什么的)
68.    Testing Incoming Email
       检查收到的邮件
69.    Sending Email With Attachments
       发送带有附件的邮件
70.    Handling Bounced Email
       搜集邮件失败信息的反馈邮件

# Part VII—Appendix
1.  Resources
    1. Bibliography
    2. Source Code

