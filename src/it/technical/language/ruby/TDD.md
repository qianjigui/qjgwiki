---
title: Ruby开发模式学习
tags: TDD BDD
tagline: 通过开发模式来保证开发质量与效率
---

# 整体介绍

在敏捷开发的过程中, 

BDD要解决的一个关键问题是提升问题领域人员和解决方案领域人员之间的交流。
BDD的目的是为了创建并发展一个这两个领域之间相互理解的公共区域，创建一种公共语言，一种普及的语言（正如领域驱动设计中所定义的那样）。

## 测试/行为驱动开发技术栈

- [cucumber](http://cukes.info/)
- [RSpec](http://rspec.info/)
- nUnit
    - Mock & Stubs 用于测试数据的生成

## BDD
- Spec

## TDD
- nUnit

# 相关使用的问题总结

## RSPEC

### development database to test database

添加一个第三方支持:

        gem 'db_fixtures_dump'

在需要的环境中, 运行 `rake db:fixtures:dump RAILS_ENV=development`

不过这些数据输出的yml文件有个问题,会在每个单项前添加yml文档开始标记`---`, 导致后面的数据无法解析.
目前需要再通过脚本清理掉.

目前主流的测试对象生成方法, 已经转向factory_girl,
如果需要通过yml+fixtures的方式, 请注意所有的加载方法都只能在 `it` 语句生效.

        fixtures :post

        it 'load post' do
            post(:a)
        end

### Rspec error: Diff is not a module

主要是由于 rspec 会通过反射进行所有 ActiveModel 的加载与查找,
其实现方法则是通过文件的require, 而rspec依赖的包中有文件名称与diff.rb相同, 从而导致
无法加载用户自己定义的 diff.rb 

解决方法:

* 在设计时, 不要用diff 名称
* 在spec中, 先行加载 diff.rb

        # spec/rails_helper.rb
        # This file is copied to spec/ when you run 'rails generate rspec:install'
        ENV["RAILS_ENV"] ||= 'test'
        require 'spec_helper'
        require File.expand_path("../../config/environment", __FILE__)
        #### Add this line Begin
        Dir[Rails.root.join("app/models/diff.rb")].each { |f| require f }
        #### End
        require 'rspec/rails'

