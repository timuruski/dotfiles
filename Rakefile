desc "Symlink all dotfiles."
task :install, :path do |t, args|
  default_path = File.expand_path('~')
  args.with_defaults(:path => default_path)
  Dotfiles.collect(args[:path]).each { |dotfile| dotfile.symlink! }
end

desc "Add vim plugins as submodules."
task :add_submodules do
  cmd = ["find vim/bundle -name config | grep .git" ]
  cmd << "while read d; do echo 'submodule add ' $(grep 'url = ' $d | awk '{print $3}') $(echo $d | sed -e 's/\\.git\\/config//') | xargs git; done"
  exec(cmd.join('|'))
end

task :default => :install

module Dotfiles
  class << self
    def collect(base_path)
      dotfiles = Dir.entries('.').grep(/^[^.]/)
      dotfiles.delete(File.basename(__FILE__))
      dotfiles = dotfiles.map { |p| Dotfile.new(p, base_path) }
    end
    
  end
end

class Dotfile
  attr_reader :full_path, :target_path

  def initialize(path, base_path)
    @path = path
    @full_path = File.expand_path(path, __FILE__)
    @target_path = File.expand_path(".#{path}", base_path)
  end

  def exists?
    File.exists?(target_path) || File.symlink?(target_path)
  end

  def symlink!
    unless exists?
      puts "Linking: #{full_path} -> #{target_path}"
      File.symlink(full_path, target_path) 
    end
  end

end
