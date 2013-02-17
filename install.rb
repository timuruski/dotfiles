require 'pathname'

class Dotfiles
  def initialize(source_dir = '.')
    @source_dir = source_dir

    @ignore_list = [__FILE__]
    @dotfile_list = []
    @symlink_list = []
  end

  attr_reader :source_dir

  def ignore(*patterns)
    patterns.each do |p|
      @ignore_list << p
    end
  end

  def dotfile(*patterns)
    patterns.each do |p|
      @dotfile_list << p
    end
  end

  def symlink_only(*patterns)
    patterns.each do |p|
      @symlink_list << p
    end
  end

  def install(target_dir, options = {})
    dry_run = options.fetch(:dry_run, false)

    Dir.chdir(source_dir) do
      install_table(target_dir).each do |source, target|
        # puts "  #{source} -> #{target} : #{File.exist?(target)}"
        File.symlink(source, target) unless installed?(target) || dry_run
      end
    end
  end

  def list(target_dir)
    Dir.chdir(source_dir) do
      list = install_table(target_dir).each do |source, target|
        status = installed?(target) ? 'x' : ' '
        puts "(#{status}) #{source.basename} -> #{target}"
      end
    end
  end

  def installed?(target)
    File.exists?(target) || File.symlink?(target)
  end


  protected


  def install_table(target_dir)
    dotfiles = expand(@dotfile_list)
    ignores = expand(@ignore_list)
    symlinks = expand(@symlink_list)

    table = (dotfiles - ignores).map { |source|
      prefix = symlinks.include?(source) ? '' : '.'
      target = "#{prefix}#{source}"

      source_path = Pathname.new(source).expand_path(source_dir)
      target_path = Pathname.new(target).expand_path(target_dir)

      [source_path, target_path]
    }

    table
  end

  def expand(list)
    list.flat_map { |p| Dir.glob(p) }.uniq
  end
end

dotfiles = Dotfiles.new

dotfiles.ignore 'Rakefile', 'README.md', 'tmp'
dotfiles.dotfile '*'
dotfiles.symlink_only 'bin'

dotfiles.install '~'
dotfiles.list '~'
