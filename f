#!/usr/bin/env ruby
# Copyright (C) 2003-2011 Wang Pengcheng <wpc0000@gmail.com>
# , released under the MIT license
# You may obtain a template of the MIT License at
# http://www.opensource.org/licenses/mit-license.php
$KCODE = 'utf8'

# Return a file list
def get_files(conf)
  build = conf[:build]
  Dir[build[:src][:dir]+'/**/**'].select {|f| File.file?(f) and !f.include?(build[:encrypt][:suffix]) }
end

# Search the matching filename
# return nil means Don't find the file
def search(files,keyword)
  require 'rubygems'
  require 'diff/lcs'
  file = nil
  len = 0
  files.each do |f|
    name = f.downcase
    lcs = Diff::LCS.LCS(name, keyword).length
    lcs = lcs * 2 if name.include?(keyword)
    if lcs > len
      len = lcs
      file = f
    end
  end
  file
end

# Open the file by applications
# true means find the right tool
# false means there is not a fitable tool
def open(file, conf)
  types = conf[:types]
  f = true
  case file
  when /#{types[:mm]}/
    fork { system 'freemind',file }
  when /#{types[:wiki]}/
    system 'gvim', file
  else
    f = false
  end
  f
end

def notify(is_terminal, message)
  if is_terminal
    puts message
  else
    %x[/usr/bin/notify-send "Knowledge Find Tip" "#{message}"]
  end
  exit 1
end

# Parse Input argument
def opt_parse(args, options)
  parser = OptionParser.new do |opts|
    opts.banner = "Usage: f [options] keyword"
    opts.separator "specific options:"
    opts.on('-g', '--gui', 'Run command in GUI') do |v|
      options.terminal = false
    end

    opts.on_tail('-h', '--help', 'Show Help') do
      puts opts
      exit
    end
  end
  begin
    parser.parse(args).join(' ')
  rescue OptionParser::InvalidOption
    notify(options.terminal, parser.to_s)
  end
end

require 'optparse'
require 'ostruct'
options = OpenStruct.new
options.terminal = true

keyword = opt_parse(ARGV, options)

notify(options.terminal, 'Please input keywords') if keyword == ''

require 'script/utils'
conf = KnowledgeUtils::CONFS
files = get_files(conf)
file = search(files,keyword.downcase)
notify(options.terminal, 'Can NOT find the file with keyword:'+keyword) unless file
notify(options.terminal, 'Can NOT find the tool to open:'+file)unless open(file,conf)

