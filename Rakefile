desc "Symlink all dotfiles."
task :install, :path do |t, args|
  Dotfiles.collect.each { |dotfile| dotfile.symlink! }
end

desc "List files"
task :list do
  Dotfiles.collect.each { |dotfile| puts dotfile.desc }
end

desc "Add vim plugins as submodules."
task :add_submodules do
  cmd = ["find vim/bundle -name config | grep .git" ]
  cmd << "while read d; do echo 'submodule add ' $(grep 'url = ' $d | awk '{print $3}') $(echo $d | sed -e 's/\\.git\\/config//') | xargs git; done"
  exec(cmd.join('|'))
end

desc "Manually generate a .gitmodules file"
task :generate_submodules do
  cmd = ["find vim/bundle -name config | grep .git" ]
  cmd << "while read d; do echo $(grep 'url = ' $d | awk '{print $3}') $(echo $d | sed -e 's/\\.git\\/config//'); done"
  submodules = ""
  `#{cmd.join('|')}`.lines do |line|
    url, path = line.split(' ')
    submodules << <<-EOS
[submodule "#{path.chomp('/')}"]
  path = #{path}
  url = #{url}
EOS
  end

  print submodules
end

module Dotfiles
  IGNORE = [File.basename(__FILE__), 'tmp']
  class << self
    def collect(base_path = '~')
      dotfiles = Dir.entries('.').grep(/^[^.].+[^~]$/)
      dotfiles.reject! { |name| IGNORE.include?(name) }
      dotfiles = dotfiles.map { |p| Dotfile.new(p, base_path) }
    end
  end
end

class Dotfile
  attr_reader :path, :full_path, :target_path

  def initialize(path, base_path)
    @path = path
    @full_path = File.expand_path(path, File.dirname(__FILE__))
    @target_path = File.expand_path(".#{path}", base_path)
  end

  def desc
    "#{status} #{path} => #{short_target_path}"
  end

  def exists?
    File.exists?(target_path)
  end

  def symlinked?
    File.symlink?(target_path)
  end

  def symlink!
    unless symlinked? || exists?
      puts "Linking: #{full_path} -> #{target_path}"
      File.symlink(full_path, target_path) 
    end
  end

  def short_target_path
    target_path.sub(File.expand_path('~'), '~')
  end

  def status
    case
    when symlinked? then '*'
    when exists? then '#'
    else ' '
    end
  end
end
