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
                    @metas = {}
                    @isWiki = false
                    @ismm = false
                end

                def to_wiki
                    @isWiki = true
                end
                def wiki?
                    @isWiki
                end
                def to_mm
                    @ismm = true
                end
                def mm?
                    @ismm
                end

                def reset
                    reset_meta
                    @ismm = false
                    @isWiki =false
                end

                def reset_meta
                    @metas[:title] = 'UNKNOW'
                    @metas[:tags] ='undefine'
                end

                def page_title=(value)
                    @metas[:title] = value
                end
                def page_tags=(value)
                    @metas[:tags] = value
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

                def header
<<STRING
---
title: #{@metas[:title]}
tags: #{@metas[:tags]}
---
STRING
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
                    # TODO There is a bug, if there are more than one link in one line
                    if line=~/\[(.+)?\]/
                        r = Regexp.last_match
                        data = r[1]
                        #What a fuck ,there are some [] in wiki, so we should skip it
                        if data=~/\A[A-Z][a-z_]|http/
                            ctx[@key] = true
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
                        @newurl = @url
                        isPicture= false
                        isInternal=false
                        #process url
                        case @url
                        when /\A[A-Z]\w+/
                            isInternal=true
                            path =ctx.get_file_path(@url)
                            if path.nil?
                                ctx.conf.warn("Wrong link %s @ %s" % [@url, ctx.file])
                            else
                                @newurl=relative_path(ctx.file, path)
                                @newurl = @newurl.chomp(File.extname(@newurl)) 
                                ctx.conf.debug("From %s to %s with new url=%s" % [@url, path, @newurl])
                            end
                        when /gif|jpeg|jpg|png\Z/
                            @newurl = @url
                            isPicture= true
                            ctx.conf.debug('Picture:'+@newurl)
                        end
                        unless isPicture
                            unless isInternal
                                newline = newline.sub(/\[(.+)?\]/,("[%s](%s title='urlpage')" % [@linkword, @newurl]))
                            else
                                #TODO Define the internal url process
                                newline = newline.sub(/\[(.+)?\]/,("[%s](=%s title='urlpage')" % [@linkword, @newurl]))
                            end
                        else
                            newline = newline.sub(/\[(.+)?\]/,("![%s](%s title='urlpicture')" % [@linkword, @newurl]))
                        end
                    end
                    newline
                end
                def finish(ctx, line)
                    ctx[@key] = false
                end
                def relative_path(from, to)
                    len = [from.length, to.length].min
                    diffi=0
                    while from[diffi]==to[diffi]
                        diffi +=1
                    end
                    parent_dis=0
                    i = diffi
                    while i<from.length
                        parent_dis +=1 if '/'[0]==from[i]
                        i+=1
                    end
                    res = ''
                    res += '../' * parent_dis
                    res += to[diffi..-1]
                    res
                end
            end

=begin
    #summary	 One-line summary of the page
    #labels	     Comma-separated list of labels (filled in automatically via the web UI)
    #sidebar	 See Side navigation
    <wiki:toc max_depth="1" />
=end
            class MetaDataConvert
                def initialize(ctx)
                    @key = :MetaDataConvert
                    ctx[@key] = false
                end
                def prepare(ctx, line)
                    return if ctx[ProgramCodeConvert::IN_CODE_PART]
                    ctx[@key] =true
                    case line
                    when /\A *#summary (.+)\Z/
                        ctx.page_title = Regexp.last_match[1]
                    when /\A *#labels (.+)\Z/
                        ctx.page_tags = Regexp.last_match[1]
                    when /\A *#sidebar (.+)\Z/
                    when /\A *<wiki:toc/
                    else
                        ctx[@key] = false
                    end
                end
                def process(ctx, line)
                    newline = line
                    newline='' if ctx[@key]
                    newline
                end
                def finish(ctx, line)
                    ctx[@key] = false
                end
            end

=begin
|| xxxx || xxxxx || xxxxxx
=end
            class TableConvert
                IS_FIRST_ROW = :TableConvertIsFirstRow
                IS_IN_TABLE = :TableConvertIsInTable
                def initialize(ctx)
                    @key = :TableConvert
                    ctx[@key] = false
                    ctx[IS_FIRST_ROW] = false
                    ctx[IS_IN_TABLE] = false
                end
                def prepare(ctx, line)
                    return if ctx[ProgramCodeConvert::IN_CODE_PART]
                    if line=~/\|\|.+\|\|/
                        ctx[@key] = true
                        if ctx[IS_FIRST_ROW]
                            ctx[IS_FIRST_ROW] = false
                        elsif not ctx[IS_IN_TABLE]
                            ctx[IS_FIRST_ROW] = true
                            newline = line.gsub('||','|')
                            line = ['|'] * (line.length - newline.length)
                            @headerline = "\n"+line.join('------')
                        end
                        ctx[IS_IN_TABLE] = true
                    else
                        ctx[IS_FIRST_ROW] = false
                        ctx[IS_IN_TABLE] = false
                    end
                end
                def process(ctx, line)
                    newline = line
                    if ctx[@key]
                        newline  = newline.gsub('||', '|')
                        if ctx[IS_FIRST_ROW]
                            newline += @headerline
                            ctx.conf.warn(ctx.file,'have table')
                        end
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
                    @meta = MetaDataConvert.new(@ctx)
                    @table = TableConvert.new(@ctx)
                    @list = [@code, @order, @header, @url, @table, @meta]
                    @list_mm = [@code, @url]
                end
                def add_file_map(file,dest)
                    @ctx.add_file_map(file,dest)
                end
                def run_wiki(path)
                    @ctx.reset
                    @ctx.to_wiki
                    res = run(path, @list)
                    @ctx.conf.debug @ctx.header
                    mode = 0644
                    generate_res(path, [@ctx.header, res.join("\n")], mode)
                end
                def run_mm(path)
                    @ctx.reset
                    @ctx.to_mm
                    res = run(path, @list_mm)
                    @ctx.conf.debug @ctx.header
                    mode = 0755
                    generate_res(path, res, mode)
                end
                def generate_res(path, res, mode)
                    data =File.read(path)
                    newdata=res.join("\n")+"\n"
                    unless data==newdata
                        FileUtils.rm(path)
                        File.open(path,'w') do |f|
                            f.chmod(mode)
                            f.puts newdata
                        end
                    end
                end
                def run(path, list)
                    @ctx.file = path
                    data = File.read(path)
                    res = []
                    data.split("\n").each do |line|
                        newline = line
                        list.each do |c|
                            c.prepare(@ctx, newline)
                        end
                        list.each do |c|
                            newline = c.process(@ctx, newline)
                        end
                        list.each do |c|
                            c.finish(@ctx, newline)
                        end
                        res << newline
                    end
                    res
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
                FileSet.files(@src+'/**/**'+@types[:wiki], /\/#{@encrypt_dir}\//).each do |file|
                    dest = dest_name(file, @src, @dir_index, @types[:wiki] , '', '')
                    @conv.add_file_map(file, dest)
                end
                FileSet.files(@src+'/**/**'+@types[:mm], /\/#{@encrypt_dir}\//).each do |file|
                    dest = dest_name(file, @src, @dir_index, @types[:mm] , '', '')
                    @conv.add_file_map(file, dest)
                end
            end
            def generate_imp
                FileSet.files(@src+'/**/**'+@types[:wiki], /\/#{@encrypt_dir}\//).each do |file|
                    @conf.debug('convert:'+file)
                    @conv.run_wiki(file)
                end
                FileSet.files(@src+'/**/**'+@types[:mm], /\/#{@encrypt_dir}\//).each do |file|
                    @conf.debug('convert:'+file)
                    @conv.run_mm(file)
                end
            end
        end
    end
end
