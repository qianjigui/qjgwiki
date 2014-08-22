---
title: Ruby on Rails 相关技术
tags: Rails
---

# 相关技术

* [Rails Recipes](<%=(../language/ruby/RailsRecipes)l%>)
* [Advanced Rails Recipes](<%=(../language/ruby/AdvancedRailsRecipes)l%>)
* [Rspec](<%=(../language/ruby/TDD)l%>)

# 系统优化

## 小系统优化

* 分库分表
* 读写分离
* DB数据内存化: 利用LRU进行部分内存化的优化处理, 这样便于数据局部性的处理
    * Redis
    * MemoryCache
    * 开发时注意缓存同步

# 可用框架技术点

## MYSQL 数据库使用

```shell
# For server
sudo apt-get install mysql-server
# For mysql2 gem
sudo apt-get install libmysqlclient-dev
```

* 优先使用mysql2 gem
* 注意从数据库到应用系统的整个编码体系
    * Database : UTF-8
        * Change default encoding: http://stackoverflow.com/questions/3513773/change-mysql-default-character-set-to-utf-8-in-my-cnf
        * Add default database: https://www.digitalocean.com/community/tutorials/scaling-ruby-on-rails-setting-up-a-dedicated-mysql-server-part-2
    * 传输解码 : UTF-8
    * 应用自身 : UTF-8

<script src="https://gist.github.com/qianjigui/00502e6218a32526187f.js"></script>

## Sidekiq 队列处理器

### Install

* 依赖的数据库:

        sudo add-apt-repository ppa:chris-lea/redis-server
        sudo apt-get install redis-server

* Gemfile:

        # For queue process
        gem 'sidekiq'
        # sidekiq monitor
        gem 'sinatra', '>= 1.3.0', :require => nil

### 数据清理

`rails console -e development`

```ruby
# Clear Sidekiq tasks
Sidekiq.redis { |conn| conn.flushdb }
```


