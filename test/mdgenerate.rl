class ScannerForMarkdownExtension
    def generate(info, file)
        data = File.read(file)
        link_url = nil
        metadata = ''
        bodydata = ''
        isInternalLink = false
        isGeneratedLink = false
        %%{
            machine _ScannerForMarkdownExtension;
            write data;
            action header_def{
            metadata = metadata[0...-4]
            p metadata
@header=<<HEADER
---
category: #{info.category}
#{metadata}
---
HEADER
            }
            action add_header{
                metadata += fc.chr
            }
            action add_body{
                unless isInternalLink
                    if isGeneratedLink
                        isGeneratedLink=false
                    else
                        bodydata += fc.chr 
                    end
                end
            }

            action init_link{
                isInternalLink = true
                bodydata = bodydata[0...-4]
                relative_url = ''
            }
            action add_link{
                relative_url += fc.chr
            }
            action gen_link{
                bodydata+=link_url
                isInternalLink = false
                isGeneratedLink= true
            }

            action link_to{
                link_url = info.link_to(relative_url)
            }
            action img_to{
                link_url = info.img_to(relative_url)
            }

            main :=
                    '---\n'

                    (any >add_header)*

                    ('\n---') @header_def

                    (
                        (
                            ('<%=(') @init_link

                            ( (any-')')+ $add_link )

                            (')l'@link_to | ')i'@img_to)

                            ('%>') @gen_link
                        )
                        |
                        (any @add_body)
                    )+
                ;
            write init;
            write exec;
        }%%
        @header+bodydata
    end
end

