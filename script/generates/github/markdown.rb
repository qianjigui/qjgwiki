#!/usr/bin/ruby
#

module KnowledgeUtils
    module Generate
        class MarkdownGenerator < GenerateBase

            include MarkdownHelper

            def set_tags
                @conf.log_tag = 'Markdown'
            end

            def prepare_img
                @env = @conf
                @mdtype = @env[:types][:md]
                @ctx = MDContext.new(@env, @mdtype, @mdtype)
            end

            def generate_img
                gen = ScannerForMarkdownExtension.new
                FileSet.files(@src+'/**/**'+@mdtype, /\/#{@encrypt_dir}\//).each do |file|
                    info = MDInfo.new(file,@ctx)
                    res = gen.generate(info, file)
                    path=@src+'/'+info.dstpath
                    File.open(path,'a') do |f|
                        f.puts res
                    end
                end
            end

            def clean_img
            end
        end
    end
end
