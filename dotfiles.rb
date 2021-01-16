# TODO(timuruski)
# Dry-run
# Warn if file exists (and not symlink)
# Create directory path as needed
# Install individual file
# Import a file into repo and replace with symlink

# require "pathname"
require "fileutils"

module Dotfiles
  def self.install(src: ".", dest: "~", dry_run: true, &block)
    installer = Installer.new(src, dest)
    installer.setup(&block)

    if dry_run
      installer.dry_run
    else
      # installer.dry_run
      installer.install
    end
  end

  class Installer
    def initialize(src_dir, dest_dir)
      @src_dir = src_dir
      @dest_dir = dest_dir

      @links = []
    end

    def setup(&block)
      instance_eval(&block)
    end

    def install
      @links.flatten.each do |link|
        link.create
      end
    end

    def dry_run
      puts "Dotfiles --"
      @links.each do |link|
        puts "  #{link.src_path} -> #{link.dest_path}"
      end
    end

    def symlink(pattern, dot_prefix: true)
      @links.concat Dir.glob(pattern).map { |filename|
        src_path = filename
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
      File.symlink(@src_path, @dest_path)
    end
  end
end
