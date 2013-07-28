require "valt/version"
require "thor"
require "yaml"
require "yaml/store"
require "pathname"
require "fileutils"

#TODO: set hook in ~/.bashrc, ~/.zshrc that sources ~/.valt.d/valt.sh if exists
#TODO: create ~/.valt.d/valt.sh to check ~/.valtrc for which directory and source files there
#TODO: ~/.valt.d/zph/.valt_local should prepend ~/.valt.d/profile/bin onto $PATH


module Valt
  class CLI < Thor

    desc "profile_name", "use alternate vim configs"
    def init(path="~/")
      valtrc = File.expand_path("#{path}.valtrc")
      if File.exists?(valtrc)
        puts "Valtrc found, please remove or manually copy valtrc"
      else
        Helper.install_valtrc(path)
      end

      valt_d = File.expand_path("#{path}.valt.d")
      if File.exists?(File.expand_path("#{path}.valt.d") )
        puts "Valt.d found, please remove or manually copy valt.d"
      else
        Helper.install_valt_d(path)
      end
    end

    desc "install profile dotfile_repo", "install new profile from git repo"
    def install(profile, url)
      puts username
      Dir.mkdir(File.expand_path("~/.valt.d/#{profile}"))

      puts url
      Dir.mktmpdir do |dir|
        #TODO: accoutnf or submodules
        Dir.chdir(dir) do
          # URI.parse(url)
          `\git clone #{url} dotfiles`
          Dir.chdir("dotfiles") do

            `\git submodule init`
            `\git submodule update`
            vimrc = Dir.glob("#{dir}/**/.vimrc")[0]
            vim_dir = Dir.glob("#{dir}/**/.vim")[0]

            valt_d_profile = File.expand_path("~/.valt.d/#{profile}")

            # [vimrc, vim_dir].each do |resource|
            #   FileUtils.copy(resource, valt_d_profile)
            # end
            FileUtils.cp(vimrc, valt_d_profile)
            FileUtils.cp_r(vim_dir, valt_d_profile)

          end
        end
      end

    end

    desc "list_profiles", "show all profiles"
    def list(valt_path="~/.valt.d")
      folders = Dir.glob("#{File.expand_path(valt_path)}/*").map { |f| f.split("/")[-1] }
      puts "These are the profiles available (select via `valt use name`):\n#{folders.join("\n")}"
    end

    desc "use", "use specific profile"
    def use(profile)
      valtrc = YAML.load_file(Config.valtrc_path)
      store = YAML::Store.new(Config.valtrc_path)

      store.transaction do
        store[:username] = profile
      end

    end
  end

  module Helper
    extend self

      def install_valtrc(path)
        valtrc = "#{path}.valtrc"
        valtrc_path = File.expand_path(valtrc)
        puts "We'll put init file at #{path}"
        puts "Installing #{valtrc}"
        config = Valt::Config.create_valtrc
      end

      def install_valt_d(path)
        valt_d = "#{path}.valt.d"
        valt_d_path = File.expand_path(valt_d)
        puts "Installing ~/.valt.d/"
        current_path = Pathname.new(File.expand_path(File.join(__FILE__, ".."))).dirname
        unless Dir.exists?(valt_d_path)
          FileUtils.cp_r( "#{current_path.to_s}/templates/.valt.d" , File.expand_path(valt_d_path) )
        end
      end
  end

  class Config
    attr_accessor :content

    def self.retreive
      if File.exists? File.expand_path("~/.valtrc")
        @content = YAML.load_file(valtrc_path)
      else
        puts "No .valtrc found"
      end
    end

    def self.valtrc_path
      File.expand_path("~/.valtrc")
    end

    def self.create_valtrc(path="~/")
      valtrc_path = File.expand_path File.join(path, ".valtrc")
      File.write(valtrc_path, defaults.to_yaml)
    end

    def self.defaults
      {
       username: ENV['USER'],
       basename: ".valtrc",
       path: File.expand_path("~"),
       full_path: File.expand_path(File.join("~", ".valtrc")),
       valt_d_path: File.expand_path("~/.valt.d"),
       version: Valt::VERSION,
      }
    end
  end
end
