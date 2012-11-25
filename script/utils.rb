require 'rake'
require 'yaml'
require 'fileutils'

module KnowledgeUtils
  IS_DEBUG = true

  MODULE_PATH = File.dirname(File.expand_path(__FILE__))

  # File Set Utilities
  class FileSet
    def self.files(dir, *exc_patterns)
      files = []
      Dir[dir].each do |file|
        next if File.directory?(file)
        isIn = true
        exc_patterns.each do |pattern|
          if pattern=~file
            isIn = false
            break
          end
        end
        files<<file if isIn
      end
      files
    end
  end

  # The Wiki Generate Framework Status system
  class Environment
    attr_accessor :log_tag
    def initialize(*paths)
      ymls = FileList.new(paths)
      @confs = {}
      ymls.each do |yml|
        @confs.merge! YAML.load_file(yml)
      end
      @log_tag = ''
      @tag_files = {}
    end

    def add_tag_file(file, *tags)
        tags.each do |tag|
            @tag_files[tag] ||=[]
            @tag_files[tag] << file
        end
    end
    def tag_files(*tags)
        res = []
        tags.each do |tag|
            res += @tag_files[tag]
        end
        res.uniq.collect do |file|
          file.gsub(/\/+/, '/')
        end
    end

    def [] (arg)
      @confs[arg]
    end

    def warn(*logs)
      log('Warn', logs)
    end

    def debug(*logs)
      log('Debug', logs) if(IS_DEBUG)
    end

    def log(pre, *logs)
      puts "#{pre}[#{@log_tag}]: #{logs.join(' ')}"
    end
  end

  CONFS = Environment.new('*.yml','.*.yml')

  require MODULE_PATH+'/genutils'
end
