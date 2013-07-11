require "valt/version"
require "thor"

module Valt
  class CLI < Thor

    desc "profile_name", "use alternate vim configs"
    def init(path="~/.valtrc")
      puts "We'll put init file at #{File.expand_path("~/")}"
    end

    desc "list_profiles", "show all profiles"
    def list(path="~/.valt.d")
      folders = Dir.glob("#{File.expand_path(path)}/*").map { |f| f.split("/")[-1] }
      puts "These are the profiles available in #{folders}"
    end

  end
end
