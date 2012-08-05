module KnowledgeUtils
  module Generate
    class GoogleWikiGenerator < GenerateBase

      def set_tags
        @conf.log_tag = 'Wiki'
      end

      def prepare_imp
        @wiki_dir = @wiki[:dir]+'/'
        @wiki_suffix = @wiki[:suffix]
        @dir_index = /\A#{@conf[:build][:src][:index]}/i

        #clean
      end

      def generate_imp
        opts = []
        opts << {:type => @types[:wiki], :cp=>true}
        opts << {:type => @types[:twi], :cp=>false}
        opts.each do |k|
          FileSet.files(@src+'/**/**'+k[:type], /\/#{@encrypt_dir}\//).each do |file|
            dest = dest_name(file, @src, @dir_index, k[:type], @wiki_suffix, @wiki_dir)
            @conf.add_tag_file(dest, @wiki_suffix)
            if k[:cp]
              if refresh?(file,dest)
                @conf.log('Refresh Wiki', file)
                cp_files(file, dest)
                touch_mtime dest, file
              end
            else
              mv_files(file, dest)
            end
          end
        end
      end

      def clean_imp
        FileSet.files(@wiki_dir+'/**/**'+@wiki_suffix).each do |file|
          @conf.debug('Delete', file)
          File.delete(file)
        end
      end

    end
  end
end

