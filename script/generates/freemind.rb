require 'rexml/document'

module KnowledgeUtils
  module Generate
    class FreemindGenerator < GenerateBase

      def set_tags
        @conf.log_tag = 'FreeMindMap'
      end

      def prepare_imp
        @wiki_dir = @wiki[:dir]+'/'
        @wiki_suffix = @wiki[:suffix]
        @dir_index = @conf[:build][:src][:index]

        @mm = @type[:mm]
        @twi= @type[:twi]

        clean
      end

      def generate_imp
        FileSet.files(@src+'/**/**'+@mm, /\/#{@encrypt_dir}\//).each do |file|
        end
      end

      def clean_imp
        FileSet.files(@src+'/**/**'+@twi).each do |file|
          @conf.debug('Delete', file)
          File.delete(file)
        end
      end

      private
      VALUE = 'TEXT'

      def pre_tag(level)
        case level
        when 1 then '='
        when 2 then '=='
        else
          ('  '*level)+'*  '
        end
      end

      def end_tag(level)
        case level
        when 1 then '='
        when 2 then '=='
        else
        end
      end

      def traver(root, level, file)
        root.elements.each('node') do |node|
          file.puts pre_tag(level)+node.attributes[VALUE]+end_tag(level)
          traver(node, level+1)
        end
      end

      def to_wiki(file, mm, twi)
        data = File.read(file)
        doc = REXML::Document.new(data)
        root = nil
        doc.elements.each('map/node') do |node|
          root = node
        end
        File.open(file.sub(mm,twi), 'w') do |f|
          sum = root.attributes[VALUE]
          f.puts '#summary '+ sum
          f.puts '='+sum+'='
          traver(root, 1, f)
        end
      end
    end
  end
end

