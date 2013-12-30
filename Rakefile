#!/usr/bin/env rake
# encoding: UTF-8
# Copyright (C) 2003-2011 Wang Pengcheng <wpc0000@gmail.com>
# , released under the MIT license
# You may obtain a template of the MIT License at
# http://www.opensource.org/licenses/mit-license.php


SCRIPT_UTILS_RELATE_PATH='script/utils'
if defined?(require_relative)
    require_relative SCRIPT_UTILS_RELATE_PATH
else
    require SCRIPT_UTILS_RELATE_PATH
end

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
encrypt=[EncryptGenerator.new(CONFS), CleanLostGenerator.new(CONFS,dir+'/**/**'+crypt_suf,crypt_suf)]
md=[Freemind2MarkDownGenerator.new(CONFS), MarkdownGenerator.new(CONFS)]

def prepare_and_generate(gens)
  gens.each do |g|
    g.prepare
  end
  gens.each do |g|
    g.generate
  end
end

task :gen_make do
  prepare_and_generate(generators)
end

desc 'Encrypt gpg files'
task :enc do
    prepare_and_generate(encrypt)
end

task :default => :release

desc 'Relase the source codes[ENC and mardown generate]'
task :release => [:enc, :md2md]

desc 'Convert Google Wiki to Markdown'
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
    prepare_and_generate(md)
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
    prepare_and_generate(unpacks)
end
