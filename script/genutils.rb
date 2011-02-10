#!/usr/bin/env ruby
# Copyright (C) 2003-2011 Wang Pengcheng <wpc0000@gmail.com>
# , released under the MIT license
# You may obtain a template of the MIT License at
# http://www.opensource.org/licenses/mit-license.php
$KCODE = 'utf8'

module KnowledgeUtils
  module Generate
    class GenerateBase
      DIRECTORY = 'generates'

      def initialize(conf)
        @conf = conf
        build = @conf[:build]
        encrypt= build[:encrypt]
        @encrypt_dir = encrypt[:dir]
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
    end
    Dir[MODULE_PATH+'/'+GenerateBase::DIRECTORY+'/*.rb'].each do |gfile|
      require gfile
    end
  end

end
