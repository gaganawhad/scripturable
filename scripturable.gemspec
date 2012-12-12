# -*- encoding: utf-8 -*-
require File.expand_path('../lib/scripturable/version', __FILE__)
$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "scripturable/version"

Gem::Specification.new do |gem|
  gem.authors       = ["Gagan Awhad"]
  gem.email         = ["gagan.awhad@desiringgod.org"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = %q{TODO: Give a homepage url}

  gem.files         = `git ls-files`.split($\)
  gem.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "scripturable"
  gem.require_paths = ["lib"]
  gem.version       = Scripturable::VERSION
  gem.add_dependency "rails", "~> 3.2.9"
  gem.add_development_dependency "sqlite3"
  gem.add_development_dependency "rspec-rails"
end
