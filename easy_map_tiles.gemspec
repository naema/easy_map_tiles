# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'easy_map_tiles/version'

Gem::Specification.new do |spec|
  spec.name          = "easy_map_tiles"
  spec.version       = EasyMapTiles::VERSION
  spec.authors       = ["naema"]
  spec.email         = ["naemyx@gmail.com"]
  spec.summary       = %q{Generate simple tiles from google maps}
  spec.description   = %q{Generate simple tiles from google maps that you can use for backgrounds or previews.}
  spec.homepage      = "https://github.com/naema/easy_map_tiles"
  spec.license       = "MIT"

  spec.files         = Dir["{lib,spec}/**/*"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
