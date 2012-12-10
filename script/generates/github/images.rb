require 'openssl'

module KnowledgeUtils
  module Generate
    class InternalImageGenerator < GenerateBase

      def set_tags
        @conf.log_tag = 'InternalImageGenerator'
      end

      def prepare_imp
          @output_image_dir_base = @conf[:build][:output][:img_dir_base]
          @src_image_dir=@conf[:build][:src][:img]
          @src=@conf[:build][:src][:dir]
      end

      def generate_imp
        imgfiles = FileSet.files(@src+'/**/'+@src_image_dir+'/**')
        imgfiles.each do |file|
          outfile =file.sub(@src, @output_image_dir_base)
          if refresh?(file,outfile)
              @conf.warn(file)
              FileUtils.mkdir_p(File.dirname(outfile))
              File.delete(outfile) if File.exist?(outfile)
              FileUtils.cp(file,outfile)
          end
        end
      end

      def clean_imp
      end
    end

  end
end

