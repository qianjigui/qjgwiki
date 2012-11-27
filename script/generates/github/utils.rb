#!/usr/bin/ruby
#

#http://www.ruby-doc.org/stdlib-1.9.3/libdoc/pathname/rdoc/Pathname.html#method-i-relative_path_from
require 'pathname'

module KnowledgeUtils
    module Generate
        module MarkdownHelper
            class MDContext
                attr_reader :src,:srctype,:dsttype
                def initialize(conf, srctype, dsttype)
                    @src=conf[:build][:src][:dir]
                    @srctype=srctype
                    @dsttype=dsttype
                end
            end
            class MDInfo
                @@urlmap = {}
                def initialize(path, ctx)
                    @srcpath = path
                    @ctx = ctx

                    #For metadata
                    init_file_time(path)
                    init_category(path, ctx)
                    #For linking
                    add_url_map(localpath, link)
                end

                def dstpath
                    @dstpathWithoutType+@ctx.dsttype
                end

                def localpath
                    @localpath
                end

                # The '/' is in the first
                def link
                    @dstpathWithoutType
                end

                # The url does NOT contain suffix, so you don't have to care about the suffix in linking
                def link_to(relative_url)
                end

                private
                def init_file_time(path)
                    #TODO I don't like this style~~
                    res = %x[git log --format=%ci #{path}]
                    @ctime = res.split("\n")
                    @mtime = @ctime[0]
                    @ctime = @ctime[-1]
                    @prefix= @ctime.split(' ')[0]+'-'
                end
                def init_category(path, ctx)
                    src=ctx.src
                    dir=File.dirname(path)
                    @category=dir.sub(src,'')
                    @name = File.basename(path, ctx.srctype)
                    @localpath = @category+'/'+@name
                    @dstpathWithoutType='/'+@category+'/'+@prefix+@name
                end

                def add_url_map(localpath, link)
                    @@urlmap[localpath]=link
                end
            end
        end
    end
end
