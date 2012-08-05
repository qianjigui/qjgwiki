module KnowledgeUtils
  module Generate
    class CleanLostGenerator < GenerateBase

      def initialize(conf, file_reg, *res_tags)
          super(conf)
          @filereg=file_reg
          @rtags=res_tags
      end

      def set_tags
        @conf.log_tag = 'CleanLost:'+@rtags.join(',')
      end

      def prepare_imp
      end

      def generate_imp
        @destfiles = @conf.tag_files(*@rtags)
        FileSet.files(@filereg).each do |file|
          unless @destfiles.include?(file)
            @conf.warn('Remove lost file:',file)
            rm_file(file)
          end
        end
      end

      def clean_imp
        @conf.debug('Clean')
      end

    end
  end
end

