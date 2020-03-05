require 'pathname'
require 'optparse'

module Dotfiles
  # Triggers installation of dotfiles, handles parsing command-line
  # arguments and target directory using defaults.
  def self.exec(args = ARGV)
    options = Options.parse!(args)

    no_install = options.fetch(:no_install)
    force = options.fetch(:force)
    source_dir = options.fetch(:source_dir)
    target_dir = args.shift || ENV['HOME']


    installer = Installer.new(source_dir)
    yield installer if block_given?

    installer.install(target_dir, force: force) unless no_install
    installer.list(target_dir)

    installer
  end

  # Collates a list of files to install.
  class Installer
    def initialize(source_dir)
      @source_dir = source_dir

      install_script = $0

      @ignore_list = [install_script]
      @dotfile_list = []
      @symlink_list = []
    end

    attr_reader :source_dir

    def ignore(patterns)
      Array(patterns).each do |p|
        @ignore_list << p
      end
    end

    def dotfile(*patterns)
      Array(patterns).each do |p|
        @dotfile_list << p
      end
    end

    def symlink_only(*patterns)
      Array(patterns).each do |p|
        @symlink_list << p
      end
    end

    def install(target_dir, options = {})
      force = options.fetch(:force, false)

      Dir.chdir(source_dir) do
        install_table(target_dir).each do |source, target|
	  # puts "  #{source} -> #{target} : #{File.exist?(source)} #{File.exist?(target)}"
	  File.unlink(target) if force && installed?(target)
	  next if installed?(target)
          File.symlink(source, target)
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
      list
        .flat_map { |p| Dir.glob(p) }
        .map { |p| File.basename(p) }
        .uniq
    end
  end

  # Parses command line arguments.
  class Options
    def self.parse!(args)
      options = {}
      options[:no_install] = false
      options[:force] = false
      options[:source_dir] = File.dirname( File.expand_path($0) )

      parser = OptionParser.new do |opts|
        opts.banner = "Usage: install.rb [options] [target_dir]"
        opts.separator ''
        opts.separator "Default target: #{ENV['HOME']}"
        opts.separator ''

        opts.on '-l', '--list', 'Only list files installed' do |v|
          options[:no_install] = v
        end

	opts.on '-f', '--force', 'Overwrite existing symlinks' do |v|
          options[:force] = v
	end

        opts.on '-s', '--source [DIR]', String,
                "Default: #{options[:source_dir]}" do |path|
          if path.nil?
            warn '--source requires a path'
            exit
          end
          options[:source_dir] = File.expand_path(path)
        end

        opts.on_tail("-h", "--help", "Show this message") do
          puts opts
          exit
        end
      end

      parser.parse!(args)

      options
    end
  end

end
