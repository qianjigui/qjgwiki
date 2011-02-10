require 'yaml'

desc 'Hg'
namespace 'hg' do

  def confirm(msg)
    puts msg+'[y/n]?'
    f = STDIN.gets
    exit unless /y(es)?/i=~f
  end

  DEFALUT_MSG = 'Format the sources and add the comments'
  HG_CONF = YAML.load_file('.hg_auths.yml')
  HG_DEST = HG_CONF['dest'].to_s
  HG_DEST_PATH = HG_CONF[HG_DEST].to_s

  desc 'Commit sources'
  task :ci, :msg do |t,args|
    args.with_defaults(:msg => DEFALUT_MSG)
    confirm('Commit with message: '+args.msg) if DEFALUT_MSG==args.msg
    args.msg.gsub!('--**comma**--',',')
    sh 'hg', 'ci', '-m', args.msg
  end

  HG_OTHER_OPTS = ['push', 'pull', 'clone']

  HG_OTHER_OPTS.each do |opt|
    desc opt
    task opt.to_sym do
      sh 'hg', opt, HG_DEST_PATH
    end
  end

  desc 'Tar hg.tar.gz'
  task :tar do
    sh 'tar', '-cpzf', 'hg.tar.gz', '.hg'
  end
end

