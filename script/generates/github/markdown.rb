#!/usr/bin/ruby
#

module KnowledgeUtils
    module Generate
        class MarkdownGenerator < GenerateBase

            require "#{File.dirname(__FILE__)}/utils.rb"
            include MarkdownHelper

            def set_tags
                @conf.log_tag = 'Markdown'
            end

            def prepare_imp
                @env = @conf
                @mdtype = @env[:types][:md]
                @wikitype=@env[:types][:wiki]
                @outputconf=@env[:build][:output]
                @outdir = @outputconf[:dir]
                @ctx = MDContext.new(@env, @wikitype, @mdtype)
            end

            def generate_imp
                gen = ScannerForMarkdownExtension.new
                list = []
                FileSet.files(@src+'/**/**'+@wikitype, /\/#{@encrypt_dir}\//).each do |file|
                    @env.warn(file)
                    info = MDInfo.new(file,@ctx)
                    list << [info,file]
                end
                list.each do |f|
                    info,file = f
                    @env.warn(file)
                    res = gen.generate(info, file)
                    path=@outdir+'/'+info.dstpath
                    FileUtils.mkdir_p(File.dirname(path))
                    File.open(path,'w') do |f|
                        f.puts res
                    end
                end
            end

            def clean_img
            end
        end
    end
end
