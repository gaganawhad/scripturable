# -*- encoding: utf-8 -*-
require File.expand_path('../lib/scripturable/version', __FILE__)
$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "scripturable/version"

Gem::Specification.new do |gem|
  gem.authors       = ["Gagan Awhad"]
  gem.email         = ["gaganaawhad@gmail.com"]
  gem.description   = %q{Ruby gem that provides common operations based around scripture meta-data}
  gem.summary       = %q{Ruby gem that provides common operations based around scripture meta-data}
  gem.homepage      = %q{https://www.github.com/gaganawhad/scripturable}

  gem.files         = `git ls-files`.split($\)
  gem.files = Dir["{app,config,db,lib}/**/*"] + ["LICENSE", "Rakefile", "README.md"]
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "scripturable"
  gem.require_paths = ["lib"]
  gem.version       = Scripturable::VERSION
  gem.add_dependency "rails", "~> 3.2.9"
  gem.add_development_dependency "sqlite3"
  gem.add_development_dependency "rspec-rails"
end
