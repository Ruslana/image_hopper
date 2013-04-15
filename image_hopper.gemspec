# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'image_hopper/version'

Gem::Specification.new do |spec|
  spec.name          = "image_hopper"
  spec.version       = ImageHopper::VERSION
  spec.authors       = ["Ruslana Kiverskaya"]
  spec.email         = ["ruslana.kiverskaya@gmail.com"]
  spec.description   = %q{Library to download pictures from the web-site}
  spec.summary       = %q{Library to download pictures from the web-site}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
