# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'valt/version'

Gem::Specification.new do |spec|
  spec.name          = "valt"
  spec.version       = Valt::VERSION
  spec.authors       = ["ZPH"]
  spec.email         = ["Zander@civet.ws"]
  spec.description   = %q{Valt is a Vim configuration Manager}
  spec.summary       = %q{Valt makes multiple Vim configs under the same user an easy and pleasant experience.}
  spec.homepage      = "www.github.com/zph/valt"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"

  spec.add_runtime_dependency 'thor'
end
