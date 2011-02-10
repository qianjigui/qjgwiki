#!/usr/bin/env rake
# Copyright (C) 2003-2011 Wang Pengcheng <wpc0000@gmail.com>
# , released under the MIT license
# You may obtain a template of the MIT License at
# http://www.opensource.org/licenses/mit-license.php
$KCODE = 'utf8'

require 'script/utils'
require 'script/hgrake'

include KnowledgeUtils::Generate
include KnowledgeUtils
generators = [ EncryptGenerator.new(CONFS), GoogleWikiGenerator.new(CONFS) ]

task :gen_make do
  generators.each do |g|
    g.prepare
  end
  generators.each do |g|
    g.generate
  end
end

task :default => :compile

desc 'Compile All files'
task :compile => :gen_make do
end

desc 'Clean all Generated files'
task :clean do
  generators.each do |g|
    g.clean
  end
end

