# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'strawpoll/version'

Gem::Specification.new do |spec|
  spec.name          = "strawpoll"
  spec.version       = Strawpoll::VERSION
  spec.authors       = ["Pavel Astraukh"]
  spec.email         = ["paladin111333@gmail.com"]
  spec.summary       = %q{Ruby client for strawpoll.me}
  spec.description   = %q{With the help of this gem you can manipulate with polls of strawpoll.me service}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
