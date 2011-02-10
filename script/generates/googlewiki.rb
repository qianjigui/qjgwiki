module KnowledgeUtils
  module Generate
    class GoogleWikiGenerator < GenerateBase

      def set_tags
        @conf.log_tag = 'Wiki'
      end

      def prepare_imp
        @wiki_dir = @wiki[:dir]+'/'
        @wiki_suffix = @wiki[:suffix]
        @dir_index = @conf[:build][:src][:index]

        clean
      end

      def generate_imp
        opts = []
        opts << {:type => @types[:wiki], :cp=>true}
        opts << {:type => @types[:twi], :cp=>false}
        opts.each do |k|
          FileSet.files(@src+'/**/**'+k[:type], /\/#{@encrypt_dir}\//).each do |file|
            dest = dest_name(file, @src, @dir_index, k[:type], @wiki_suffix, @wiki_dir)
            if k[:cp]
              cp_files(file, dest)
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

      private
      def dest_name(file,src,dir_index,suffix,new_suffix, dest)
        dest+File.dirname(file).sub(src,'').split('/').map{|path| path.capitalize}.join('')+File.basename(file).sub(dir_index,'').capitalize.sub(suffix, new_suffix)
      end
    end
  end
end

