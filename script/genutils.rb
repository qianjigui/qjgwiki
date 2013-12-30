#!/usr/bin/env ruby
# encoding: UTF-8
# Copyright (C) 2003-2011 Wang Pengcheng <wpc0000@gmail.com>
# , released under the MIT license
# You may obtain a template of the MIT License at
# http://www.opensource.org/licenses/mit-license.php

require 'fileutils'

module KnowledgeUtils
  module Generate
    class GenerateBase
      DIRECTORY = 'generates'

      def initialize(conf)
        @conf = conf
        build = @conf[:build]
        encrypt= build[:encrypt]
        @encrypt_dir = encrypt[:dir]
        @local_res_dir = build[:res][:dir]
        @encrypt_suffix= encrypt[:suffix]
        @src = build[:src][:dir]
        @types = @conf[:types]
        @wiki = build[:wiki]
      end


      def prepare()
        set_tags
        prepare_imp
      end

      def generate()
        set_tags
        generate_imp
      end

      def clean()
        set_tags
        clean_imp
      end

      protected
      def set_tags
        @conf.log_tag = 'Base'
      end

      def prepare_imp
      end
      def generate_imp
      end
      def clean_imp
      end

      def get_mtime(file)
        File.mtime(file)
      end

      def dest_name(file,src,dir_index,suffix,new_suffix, dest)
        dest+File.dirname(file).sub(src,'').split('/').map{|path| path.capitalize}.join('')+File.basename(file).sub(dir_index,'').capitalize.sub(suffix, new_suffix)
      end

      def refresh?(file,dest)
        if File.exist?(dest)
          fm = get_mtime(file)
          dm = get_mtime(dest)
          fm>dm
        else
          true
        end
      end

      def touch_mtime(dest, time)
        time = File.mtime(time) if time.class==String
        FileUtils.touch dest, :mtime => time
      end

      def cp_files(from, dest)
        FileUtils.cp(from, dest)
      end

      def mv_files(from, dest)
        FileUtils.mv(from, dest)
      end
      def rm_file(file)
        FileUtils.rm(file)
      end
    end
    Dir[MODULE_PATH+'/'+GenerateBase::DIRECTORY+'/*.rb'].each do |gfile|
      require gfile
    end
    Dir[MODULE_PATH+'/'+GenerateBase::DIRECTORY+'/github/*.rb'].each do |gfile|
      require gfile
    end
    Dir[MODULE_PATH+'/'+'convert'+'/*.rb'].each do |gfile|
      require gfile
    end
  end

end
