# TODO(timuruski)
# - Warn if file exists (and not symlink)
# - Install individual file
# - Import a file into repo and replace with symlink
# - Cleanup dead links

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
      installer.install(force: opts.force?)
    end
  end

  class Installer
    def initialize(src_dir, dest_dir, &block)
      @src_dir = Pathname.new(src_dir)
      @dest_dir = Pathname.new(dest_dir)
      @links = []

      instance_eval(&block)
    end

    def dry_run
      @links.each do |link|
        # link.debug
        puts link.inspect
      end
    end

    def install(force: false)
      @links.each do |link|
        link.install
        puts link.inspect
      end
    end

    def dotfile(pattern, to: nil)
      symlink(pattern, dot_prefix: true, to: to)
    end

    def symlink_each(pattern, dot_prefix: false)
      Dir.glob(pattern).each do |filename|
        symlink(filename, dot_prefix: dot_prefix)
      end
    end

    def symlink(filename, dot_prefix: false, to: nil)
      dest = to || filename
      dest = "." + dest if dot_prefix

      src_path = File.expand_path(filename, @src_dir)
      dest_path = File.expand_path(dest, @dest_dir)

      @links << Symlink.new(src_path, dest_path)
    end
  end

  class Symlink
    attr_reader :src_path, :dest_path

    def initialize(src_path, dest_path)
      @src_path = src_path
      @dest_path = dest_path
    end

    def install
      return if missing?

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
      elsif missing?
        "!"
      end
    end

    def missing?
      !File.exist?(@src_path)
    end

    def installed?
      File.symlink?(@dest_path) && File.readlink(@dest_path) == @src_path
    end

    def conflict?
      File.file?(@dest_path) || File.symlink?(@dest_path) && File.readlink(@dest_path) != @src_path
    end
  end

  class Options
    DEFAULT_DEST = "~"

    def initialize(args, defaults = {})
      @dry_run = defaults.fetch(:dry_run, false)
      @force = defaults.fetch(:force, false)

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
end
