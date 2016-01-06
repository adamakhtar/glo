# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'glo/version'

Gem::Specification.new do |spec|
  spec.name          = "glo"
  spec.version       = Glo::VERSION
  spec.authors       = ["Adam Akhtar"]
  spec.email         = ["adam.akhtar@gmail.com"]

  spec.summary       = %q{Operations for your business logic}
  spec.description   = %q{Extract complex business logic scattered around your models into their own operation objects}
  spec.homepage      = "http://github.com/robodisco/glo"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "byebug"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-rspec"
end
