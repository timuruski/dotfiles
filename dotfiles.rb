# TODO(timuruski)
# Warn if file exists (and not symlink)
# Create directory path as needed
# Install individual file
# Import a file into repo and replace with symlink
# Cleanup dead links

require "fileutils"
require "optparse"
require "pathname"

module Dotfiles
  def self.install(src: ".", **opts_override, &block)
    opts = Options.new(ARGV, opts_override)
    installer = Installer.new(src, opts.dest, &block)

    if opts.dry_run?
      installer.dry_run
    else
      installer.install
    end
  end

  class Options
    DEFAULT_DEST = "~"

    def initialize(args, overrides = {})
      @dry_run = overrides[:dry_run] || false
      @force = overrides[:force] || false

      parser = OptionParser.new do |opts|
        opts.banner = "Usage: #{$0} [options] [target_dir]"
        opts.separator ""
        opts.separator "Default target: #{ENV["HOME"]}"
        # opts.separator ""

        opts.on "-d", "--debug", "Show debug info" do |value|
          @debug = value
        end

        opts.on "-l", "--list", "Only list files installed" do |value|
          @dry_run = value
        end

        opts.on "-f", "--force", "Overwrite existing symlinks" do |value|
          @force = value
        end

        opts.on_tail("-h", "--help", "Show this message") do
          puts opts
          exit
        end
      end

      parser.parse!(args)

      @dest = ARGV.first || DEFAULT_DEST
    end

    def dest
      @dest
    end

    def force?
      @force
    end

    def dry_run?
      @dry_run
    end
  end

  class Installer
    def initialize(src_dir, dest_dir, &block)
      @src_dir = src_dir
      @dest_dir = dest_dir
      @links = []

      instance_eval(&block)
    end

    def dry_run
      @links.each do |link|
        # link.debug
        puts link.inspect
      end
    end

    def install
      @links.each do |link|
        link.create
        puts link.inspect
      end
    end

    def symlink(pattern, dot_prefix: true)
      @links.concat Dir.glob(pattern).map { |filename|
        src_path = File.expand_path(filename, @src_dir)
        dest_path = File.expand_path(filename, @dest_dir)

        Symlink.create(src_path, dest_path, dot_prefix: dot_prefix)
      }
    end
  end

  class Symlink
    attr_reader :src_path, :dest_path

    def self.create(src_path, dest_path, dot_prefix: true)
      if dot_prefix
        dest_path = File.join(File.dirname(dest_path), "." + File.basename(dest_path))
      end

      new(src_path, dest_path)
    end

    def initialize(src_path, dest_path)
      @src_path = src_path
      @dest_path = dest_path
    end

    def create
      FileUtils.mkdir_p(File.dirname(@dest_path))
      FileUtils.symlink(@src_path, @dest_path) unless installed? || conflict?
    end

    def debug
      puts @src_path
      puts @dest_path
      if File.symlink?(@dest_path)
        puts File.readlink(@dest_path)
        puts File.readlink(@dest_path) == @src_path
      end
      puts "---"
    end

    def inspect
      src_path = Pathname.new(@src_path).relative_path_from(__dir__)
      "[#{status || " "}] #{src_path} -> #{@dest_path}"
    end

    def status
      if installed?
        "x"
      elsif conflict?
        "?"
      end
    end

    def installed?
      File.symlink?(@dest_path) && File.readlink(@dest_path) == @src_path
    end

    def conflict?
      File.file?(@dest_path) || File.symlink?(@dest_path) && File.readlink(@dest_path) != @src_path
    end
  end
end
