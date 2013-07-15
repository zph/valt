require "valt/version"
require "thor"
require "yaml"
require "yaml/store"

#TODO: set hook in ~/.bashrc, ~/.zshrc that sources ~/.valt.d/valt.sh if exists
#TODO: create ~/.valt.d/valt.sh to check ~/.valtrc for which directory and source files there
#TODO: ~/.valt.d/zph/.valt_local should prepend ~/.valt.d/profile/bin onto $PATH

module Valt
  class CLI < Thor

    desc "profile_name", "use alternate vim configs"
    def init(path)
      path ||= File.expand_path("~/.valtrc")
      puts "We'll put init file at #{path}"
      #TODO: init structure
      # create ~/.valtrc
      # create ~/.valt.d
      # fill basic hooks in ~/.valt.d
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

  class Config
    attr_accessor :content

    def self.retreive
      if File.exists? File.expand_path("~/.valtrc")
        config = valtrc_path
      else
        File.write(valtrc_path, defaults.to_yaml)
      end

      config ||= valtrc_path
      @content = YAML.load_file(config)
    end

    def self.valtrc_path
      File.expand_path("~/.valtrc")
    end

    def self.defaults
      {basename: ".valtrc",
       path: File.expand_path("~"),
       full_path: File.expand_path(File.join("~", ".valtrc")),
       valt_d_path: File.expand_path("~/.valt.d"),
       username: ENV['USER'],
       version: "0.0.1",
      }
    end
  end
end
