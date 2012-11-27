#!/usr/bin/ruby
#

module KnowledgeUtils
    module Generate
        class MarkdownGenerator < GenerateBase
            def set_tags
                @conf.log_tag = 'Markdown'
            end
            def prepare_img
            end
            def generate_img
            end
            def clean_img
            end
        end
    end
end
