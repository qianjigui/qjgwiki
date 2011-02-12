module KnowledgeUtils
  module Generate
    class IndexGenerator < GenerateBase

      def set_tags
        @conf.log_tag = 'Index'
      end

      def prepare_imp
        @wiki_dir = @wiki[:dir]+'/'
        @wiki_suffix = @wiki[:suffix]
        @dir_index = /\A#{@conf[:build][:src][:index]}/i
        @index_wiki = @wiki_dir+'/index'+@wiki_suffix
        clean
      end

      def generate_imp
        file_infos = get_file_infos(@wiki_dir, @wiki_suffix)
        file_map = get_file_map(file_infos)
        File.open(@index_wiki, 'w') do |file|
          file.puts '#summary Wiki Index'
          generate_index(file_map, file)
        end
      end

      def clean_imp
        FileSet.files(@index_wiki).each do |file|
          @conf.debug('Delete', file)
          File.delete(file)
        end
      end

      private
      UP_CHARS = ('A'[0]..'Z'[0])
      def get_path(file)
        path = ''
        file.each_char do |c|
          path << '/' if UP_CHARS.include?(c[0])
          path << c
        end
        path
      end

      def generate_index(file_map, file, level=1)
        info = file_map[:info]
        if info
          file.puts '  '*level + '* '+info[:summary]+' ['+info[:link]+']'
        end
        keys = file_map.keys.select {|k| k!=:info}
        keys.sort.each do |k|
          file.puts '  '*level + '* '+k
          generate_index(file_map[k], file, level+1)
        end
      end
      def get_file_map(file_infos)
        root = {}
        file_infos.each do |info|
          path = info[:path].split('/').select {|i| i!=''}
          p = root
          q = nil
          path.each do |step|
            q = p[step]
            unless q
              q = {}
              p[step] = q
            end
            p = q
          end
          q[:info] = info
        end
        root
      end
      def get_summary(file)
        sum = []
        File.readlines(file).each do |line|
          if /#summary/=~line
            sum << line.gsub('#summary','').gsub(/\s/,' ')
          end
        end
        sum.join(',')
      end
      def get_file_infos(wiki_dir, wiki_suffix)
        file_infos= []
        FileSet.files(wiki_dir+'/**/**'+wiki_suffix).each do |file|
          link = File.basename(file,wiki_suffix)
          path = get_path(file).sub(wiki_suffix,'')
          summary = get_summary(file)
          file_infos<<{:link => link, :path => path, :summary=>summary}
        end
        file_infos
      end

    end
  end
end

