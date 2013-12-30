#!/usr/bin/env ruby
#
# encoding: utf-8


if ARGV.length < 1
    puts <<END
    Usage: #{__FILE__} <dir>
END
    exit 1
end

dir = ARGV[0]

Dir[dir+'/**/**.md'].each do |f|
    p f
    data  = File.read(f)

    if data=~/{%\s*highlight/m
        data.gsub!(/{%\s*highlight\s+([^%\}]+)%}/) do |match|
            r = Regexp.last_match
            "\n```#{r[1].strip}"
        end
        data.gsub!(/{%\s*endhighlight\s+%}/) do |match|
            "```\n"
        end
        File.open(f,'w') do |f|
            f.print data
        end
    end
end
