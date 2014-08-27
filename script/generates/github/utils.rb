#!/usr/bin/ruby
#

#http://www.ruby-doc.org/stdlib-1.9.3/libdoc/pathname/rdoc/Pathname.html#method-i-relative_path_from
require 'pathname'

module KnowledgeUtils
    module Generate
        module MarkdownHelper
            class MDContext
                attr_reader :src, :srctype, :dsttype, :img_dir, :img_suffixes, :env, :dst_img_dir
                def initialize(env, srctype, dsttype)
                    #src directory base
                    @env = env
                    @src=env[:build][:src][:dir]
                    @mmtype = env[:types][:mm]
                    @tmdtype = env[:types][:tmd]
                    @img_dir = env[:build][:src][:img]
                    @img_suffixes = env[:types][:imgs]
                    @dst_img_dir = env[:build][:output][:img_prefix]
                    #The file type in src
                    @srctype=srctype
                    #The file type in generate directory
                    @dsttype=dsttype
                end

                def realpath(path)
                    path
                end
            end

            # This class is mapping to a markdown file
            class MDInfo

                #The url map is using for internal linking
                # localpath: the key
                #            the path in src directory without the suffix
                # link     : the value
                #            the path in dest directory without the suffix
                @@urlmap = {}

                attr_reader :category
                def initialize(path, ctx)
                    #file path in src
                    @srcpath = path
                    #converting context
                    @ctx = ctx

                    #For metadata
                    init_file_time(path)
                    init_category(path, ctx)
                    #For linking
                    add_url_map(localpath, link)
                end

                # The dest path with the suffix
                def dstpath
                    @dstpathWithoutType+@ctx.dsttype
                end

                def localpath
                    @localpath.to_s
                end

                # The '/' is the first character
                def link
                    @dstlinkWithoutType
                end

                # The url does NOT contain suffix, so you don't have to care about the suffix in linking
                #
                # This file link to other file, this function is used for calculating the other file's dest path
                # This path is equal to ( localpath + relative_url)
                def link_to(relative_url)
                    dst = dst_localpath(relative_url)
                    res = @@urlmap[dst]
                    unless res
                        @ctx.env.warn('internal link', dst, 'is error')
                        res=''
                    end
                    res
                end

                def img_to(relative_url)
                    img_basename = File.basename(relative_url)
                    img_dir = File.dirname(dst_localpath(relative_url))+'/'+@ctx.img_dir+'/'
                    img_path=@ctx.src+'/'+img_dir+img_basename
                    res = nil
                    @ctx.img_suffixes.each do |s|
                        _path=img_path+s
                        if File.exist?(_path)
                            res = _path
                            break
                        end
                    end
                    unless res
                        @ctx.env.warn('internal link image', img_path, 'is error')
                        res=''
                    end
                    Pathname.new(res).cleanpath.to_s.sub(@ctx.src, @ctx.dst_img_dir)
                end

                def lmtime
                    @mtime.split(" ")[0]
                end

                private

                def dst_localpath(relative_url)
                    r = Pathname.new(@category+'/'+relative_url).cleanpath
                    r.to_s
                end

                def init_file_time(path)
                    #TODO I don't like this style~~
                    path = @ctx.realpath(path)
                    res = %x[git log --follow --format=%ci #{path}]
                    @ctime = res.split("\n")
                    #The last commit for this file, so this is the modify time
                    now=Time.now.strftime('%Y-%m-%d')
                    @mtime = if @ctime[0]
                                 @ctime[0]
                             else
                                 now
                             end
                    #The first commit for this file, so this is the create time
                    @ctime = @ctime[-1]
                    #Because of the jeklly template, the file name should contain the prefix with a timestamp
                    #The format is YYYY-MM-DD-filename
                    @prefix = if @ctime
                        @ctime.split(' ')[0]
                    else
                        now
                    end + '-'
                end
                def init_category(path, ctx)
                    src=ctx.src
                    dir=File.dirname(path)

                    #Remove the src-base, and then it is the category.
                    #In this framework, the category is equal to src-directory.
                    #So we can manage the the article in category
                    @category=dir.sub(src+'/','')

                    #The file name which will remote the file suffix
                    @name = File.basename(path, ctx.srctype)

                    #For linking in internal system
                    @localpath = Pathname.new(@category+'/'+@name)

                    #For generate in dest directory
                    @dstpathWithoutType='/'+@prefix+@name
                    @dstlinkWithoutType='/'+@category+'/'+@prefix.gsub('-','/')+@name
                end

                def add_url_map(localpath, link)
                    @@urlmap[localpath]=link
                end
            end
        end
    end
end
