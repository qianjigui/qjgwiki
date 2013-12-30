#!/usr/bin/env ruby
#

module KnowledgeUtils
    module Generate
        class ScannerForMarkdownExtension
            def generate(info, file, ctx)
                @info = info
                @data = File.read(file)
                @ctx  = ctx
                metadata,bodydata = split_metadata_bodydata(@data)

                head = gen_head(metadata)
                body = convert_body(bodydata)
                head+body
            end

            def split_metadata_bodydata(data)
                if @data=~/\A\s*---\n(.+)---\n(.+)\Z/im
                    r = Regexp.last_match
                    metadata = r[1]
                    bodydata = r[2]
                else
                    #TODO Fix bug for here, how to support syntax
                    @ctx.env.warn('ToJekyllMarkdown Failed')
                    exit 1
                end
                [metadata,bodydata]
            end

            def gen_head(metadata)
                head=<<HEADER
---
layout: default
category: #{@info.category}
#{metadata}
---
HEADER
            end

            def convert_body(bodydata)
                res = bodydata.gsub(/(<%=\()([^%>]+)(\)l%>)+?/) do |match|
                    r = Regexp.last_match
                    @info.link_to(r[2])
                end
                res
            end
        end
    end
end
