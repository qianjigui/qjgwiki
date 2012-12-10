#!/usr/bin/env rake
# Copyright (C) 2003-2011 Wang Pengcheng <wpc0000@gmail.com>
# , released under the MIT license
# You may obtain a template of the MIT License at
# http://www.opensource.org/licenses/mit-license.php
$KCODE = 'utf8'

require 'script/utils'

include KnowledgeUtils::Generate
include KnowledgeUtils

src = CONFS[:build][:src]
dir = src[:dir]
wiki = CONFS[:build][:wiki]
wiki_dir=wiki[:dir]
wiki_suf=wiki[:suffix]
encrypt= CONFS[:build][:encrypt]
crypt_dir=encrypt[:dir]
crypt_suf=encrypt[:suffix]

generators = [ EncryptGenerator.new(CONFS), CleanLostGenerator.new(CONFS,dir+'/**/**'+crypt_suf,crypt_suf), FreemindGenerator.new(CONFS), GoogleWikiGenerator.new(CONFS), CleanLostGenerator.new(CONFS, wiki_dir+'/**/**'+wiki_suf, wiki_suf), IndexGenerator.new(CONFS) ]
unpacks=[DecryptGenerator.new(CONFS), CleanLostGenerator.new(CONFS, dir+'/**/'+crypt_dir+'/**', crypt_suf)]
conv=[GoogleWikiFormat2MarkdownFormat.new(CONFS)]
#md=[MarkdownGenerator.new(CONFS)]
#md=[Freemind2MarkDownGenerator.new(CONFS)]
md=[Freemind2MarkDownGenerator.new(CONFS), MarkdownGenerator.new(CONFS), InternalImageGenerator.new(CONFS)]

task :gen_make do
  generators.each do |g|
    g.prepare
  end
  generators.each do |g|
    g.generate
  end
end

task :default => :md2md

desc 'Compile All files'
task :compile => :gen_make do
end

desc 'Convert G2M'
task :g2m do
  conv.each do |g|
    g.prepare
  end
  conv.each do |g|
    g.generate
  end
end

desc 'Generate markdown files'
task :md2md do
  md.each do |g|
    g.prepare
  end
  md.each do |g|
    g.generate
  end
end

desc 'Clean all Generated files'
task :clean do
  md.each do |g|
    g.prepare
  end
  md.each do |g|
    g.clean
  end
end

desc 'Unpack the Data to directory'
task :unpack do
  unpacks.each do |g|
    g.prepare
  end
  unpacks.each do |g|
    g.generate
  end
end
