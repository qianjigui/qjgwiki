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
                @tmdtype = @env[:types][:tmd]
                @outputconf=@env[:build][:output]
                @outdir = @outputconf[:dir]
                @mdctx = MDContext.new(@env, @mdtype, @mdtype)
                @tmdctx = MDContext.new(@env, @tmdtype, @mdtype)
                def @tmdctx.realpath(path)
                    path.sub(@tmdtype, @mmtype)
                end
            end

            def generate_imp
                gen = ScannerForMarkdownExtension.new
                list = []
                [[@mdtype, @mdctx], [@tmdtype,@tmdctx]].each do |value|
                    type,ctx=value
                    FileSet.files(@src+'/**/**'+type, /\/(#{@encrypt_dir})|(#{@local_res_dir})\//).each do |file|
                        info = MDInfo.new(file,ctx)
                        list << [info,file]
                    end
                end
                list.each do |f|
                    info,file = f
                    res = gen.generate(info, file, @mdctx)
                    path=@outdir+'/'+info.dstpath
                    #@env.debug(file,' write to', path)
                    if refresh?(file,path)
                        @env.warn(file)
                        FileUtils.mkdir_p(File.dirname(path))
                        File.open(path,'w') do |f|
                            f.puts res
                        end
                    end
                end
            end

            def clean_img
            end
        end
    end
end
