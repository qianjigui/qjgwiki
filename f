#!/usr/bin/env ruby
# Copyright (C) 2003-2011 Wang Pengcheng <wpc0000@gmail.com>
# , released under the MIT license
# You may obtain a template of the MIT License at
# http://www.opensource.org/licenses/mit-license.php
$KCODE = 'utf8'

require 'script/utils'
require 'optparse'

conf = KnowledgeUtils::CONFS

def get_files(conf)
  build = conf[:build]
  Dir[build[:src][:dir]+'/**/**'].select {|f| File.file?(f) and !f.include?(build[:encrypt][:suffix]) }
end

files = get_files(conf)

keyword = nil
begin
  keyword = ARGV[0].downcase
rescue NoMethodError
  puts 'Please input the keyword'
  exit 1
end

require 'rubygems'
require 'diff/lcs'

file = nil

len = 0
files.each do |f|
  name = f.downcase
  lcs = Diff::LCS.LCS(name, keyword).length
  lcs = lcs * 2 if name.include?(keyword)
  if lcs > len
    len = lcs
    file = f
  end
end

types = conf[:types]
if file
  case file
  when /#{types[:mm]}/
    fork { system 'freemind',file }
  when /#{types[:wiki]}/
    system 'gvim', file
  else
    puts 'Can NOT find a right tool for:'+file
  end
else
  puts 'Can NOT find file:'+keyword
end

