---
title: Ruby Http 基础库学习
tags: HTTP
---

# 网络http请相关学习

## 基础方法

1. URI
2. 产生连接
3. 连接内部进行请求

```
require 'uri'
require 'net/http'
uri = URI('http://example.com/some_path?query=string')

Net::HTTP.start(uri.host, uri.port) do |http|
  request = Net::HTTP::Get.new uri

  response = http.request request # Net::HTTPResponse object

  request = Net::HTTP::Put.new uri
end
```

### 服务端

```
require 'webrick'
include WEBrick
port=8080
puts "Starting server: http://#{Socket.gethostname}:#{port}"
server = HTTPServer.new(:Port=>port,:DocumentRoot=>Dir::pwd )
trap("INT"){ server.shutdown }
server.start
```

## 常见问题

1. 代理
2. multimeta 表单
3. Auth
4. stream IO
5. 性能
    * http/sql 连接池技术
    * HTTP KeepAlive

