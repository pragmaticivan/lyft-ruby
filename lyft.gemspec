# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'lyft/version'

Gem::Specification.new do |spec|
  spec.name          = "lyft"
  spec.version       = Lyft::VERSION
  spec.authors       = ["Ivan Santos"]
  spec.email         = ["pragmaticivan@gmail.com"]

  spec.summary       = %q{API wrapper for the Lyft API}
  spec.description   = spec.summary
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 1.9.3'
  spec.add_dependency "oauth2",  "~> 1.0"
  spec.add_dependency "hashie",  "~> 3.2"
  spec.add_dependency "faraday", "~> 0.9"
  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "awesome_print"
  spec.add_development_dependency "codecov"

  # We use YARD for documentation
  # Extra gems for GitHub flavored MarkDown in YARD
  spec.add_development_dependency "yard"
  spec.add_development_dependency "redcarpet"
  spec.add_development_dependency "github-markdown"

  # We use VCR to mock API calls
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "webmock"
end
