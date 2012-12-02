class ScannerForMarkdownExtension
    def generate(info, file)
        data = File.read(file)
        link_url = nil
        metadata = ''
        bodydata = ''
        %%{
            machine _ScannerForMarkdownExtension;
            write data;
            action header_def{
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
                bodydata += fc.chr
            }

            action init_link{
                relative_url = ''
            }
            action add_link{
                relative_url += fc.chr
            }
            action gen_link{
                bodydata+=link_url
            }

            action link_to{
                link_url = info.link_to(relative_url)
            }
            action img_to{
                link_url = info.img_to(relative_url)
            }

            main :=
                    '---\n'

                    (any @add_header)*

                    '\n---'

                    @header_def

                    (
                        (
                            '<%=('
                                @init_link
                                (any @add_link)+
                            ')'
                            ('l'@link_to|'i'@img_to)
                            '%>'
                            @gen_link
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

