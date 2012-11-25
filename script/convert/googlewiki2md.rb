module KnowledgeUtils
    module Generate
=begin
GoogleWikiFormat to MarkdownFormat Convert
    Strategy: process file by file
        1. read the file
        2. convert file line by line
        3. convert step will share a context for table
=end
        module G2MHelper
            class ConvertContext
                attr_reader :conf
                def initialize(conf)
                    @context = {}

                    #for table first line
                    @context[:firstrow] = true
                    @conf = conf
                    @filemap = {}
                end

                def add_file_map(file,dest)
                    @filemap[dest] = file
                end

                def get_file_path(dest)
                    @filemap[dest]
                end

                def reset_row
                    @context[:firstrow] = true
                end
                def post_first_row
                    @context[:firstrow] = false
                end
                def first_row?
                    @context[:first_row]
                end

                def file=(value)
                    @file=value
                end
                def file
                    @file
                end

                def [](key)
                    @context[key]
                end
                def []=(key,value)
                    @context[key] = value
                end
            end
            class OrderedListConvert
                def initialize(ctx)
                    @key = :OrderedListConvert
                    ctx[@key] = false
                end
                def prepare(ctx, line)
                    return if ctx[ProgramCodeConvert::IN_CODE_PART]
                    ctx[@key] = true if line=~/\A *# +/
                end
                def process(ctx, line)
                    newline = line
                    newline = line.sub('#', '1.') if ctx[@key]
                    newline
                end
                def finish(ctx, line)
                    ctx[@key] = false
                end
            end
            class HeaderLineConvert
                def initialize(ctx)
                    @key = :HeaderLineConvert
                    ctx[@key] = false
                end
                def prepare(ctx, line)
                    return if ctx[ProgramCodeConvert::IN_CODE_PART]
                    ctx[@key] = true if line=~/\A *=+.+=+/
                end
                def process(ctx, line)
                    newline = line
                    newline = line.gsub('=', '#') if ctx[@key]
                    newline
                end
                def finish(ctx, line)
                    ctx[@key] = false
                end
            end
            class ProgramCodeConvert
                IN_CODE_PART = :ProgramCodeConvertInCode
                def initialize(ctx)
                    @key = :ProgramCodeConvert
                    ctx[@key] = false
                    ctx[IN_CODE_PART] = false
                end
                def prepare(ctx, line)
                    if line.include?('{{{')
                        ctx[@key] = true
                        ctx[IN_CODE_PART] = true
                    end
                    if line.include?('}}}')
                        ctx[@key] = true
                        ctx[IN_CODE_PART] = false
                    end
                end
                def process(ctx, line)
                    newline = line
                    if ctx[@key]
                        newline = newline.sub('{{{', '~~~~')
                        newline = newline.sub('}}}', '~~~~')
                    end
                    newline
                end
                def finish(ctx, line)
                    ctx[@key] = false
                end
            end
            #Should check inline url or href to outside
            class URLConvert
                def initialize(ctx)
                    @key = :URLConvert
                    ctx[@key] = false
                end
                def prepare(ctx, line)
                    # [url linkword] with a different word
                    # [url] without a word
                    # And the url may be inside or outside
                    return if ctx[ProgramCodeConvert::IN_CODE_PART]
                    if line=~/\[(.+)?\]/
                        ctx[@key] = true
                        r = Regexp.last_match
                        data = r[1]
                        #What a fuck ,there are some [] in wiki, so we should skip it
                        if data=~/\A[A-Z]|http/
                            case data
                            when /\A(\S+) (.+)/
                                r = Regexp.last_match
                                @url = r[1]
                                @linkword = r[2]
                            when /\A(\S+)\Z/
                                r = Regexp.last_match
                                @url = r[1]
                                #As the same link word
                                @linkword = r[1]
                            end
                        end
                    end
                end
                def process(ctx, line)
                    newline=line
                    if ctx[@key]
                        #process url
                        if @url=~/\A[A-Z]\w+/
                            path =ctx.get_file_path(@url)
                            if path.nil?
                                ctx.conf.debug("Wrong link %s @ %s" % [@url, ctx.file])
                            else
                                ctx.conf.debug("From %s to %s" % [@url, path])
                            end
                        end
                        newline= ("[%s](%s title='url')" % [@linkword, @url])
                        #ctx.conf.debug( "%s: %s" % [ctx.file, @url] )
                    end
                    newline
                end
                def finish(ctx, line)
                    ctx[@key] = false
                end
            end

            class Convert
                def initialize(conf)
                    @ctx = ConvertContext.new(conf)
                    @order = OrderedListConvert.new(@ctx)
                    @header=HeaderLineConvert.new(@ctx)
                    @code = ProgramCodeConvert.new(@ctx)
                    @url = URLConvert.new(@ctx)
                    @list = [@code, @order, @header, @url]
                end
                def add_file_map(file,dest)
                    @ctx.add_file_map(file,dest)
                end
                def run(path)
                    @ctx.file = path
                    data = File.read(path)
                    data.split("\n").each do |line|
                        @list.each do |c|
                            c.prepare(@ctx, line)
                        end
                        @list.each do |c|
                            c.process(@ctx, line)
                        end
                        @list.each do |c|
                            c.finish(@ctx, line)
                        end
                    end
                end
            end
        end

        class GoogleWikiFormat2MarkdownFormat < GenerateBase
            def set_tags
                @conf.log_tag = 'G2M'
            end
            def prepare_imp
                @wiki_dir = @wiki[:dir]+'/'
                @wiki_suffix = @wiki[:suffix]
                @dir_index = /\A#{@conf[:build][:src][:index]}/i
                @conv = G2MHelper::Convert.new(@conf)
            end
            def generate_imp
                FileSet.files(@src+'/**/**'+@types[:wiki], /\/#{@encrypt_dir}\//).each do |file|
                    dest = dest_name(file, @src, @dir_index, @types[:wiki] , '', '')
                    @conv.add_file_map(file, dest)
                end
                FileSet.files(@src+'/**/**'+@types[:mm], /\/#{@encrypt_dir}\//).each do |file|
                    dest = dest_name(file, @src, @dir_index, @types[:mm] , '', '')
                    @conv.add_file_map(file, dest)
                end
                FileSet.files(@src+'/**/**'+@types[:wiki], /\/#{@encrypt_dir}\//).each do |file|
                    #@conf.debug('check:'+file)
                    @conv.run(file)
                end
            end
        end
    end
end
