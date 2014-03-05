# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'acts_as_starable/version'

Gem::Specification.new do |gem|
  gem.name        = 'acts_as_starable'
  gem.version     = ActsAsStarable::VERSION
  gem.authors     = ['Dominic Giglio']
  gem.email       = ['dom@littlstar.com']
  gem.homepage    = 'https://github.com/littlstar/acts_as_starable'
  gem.summary     = %q{A Rubygem to add staring functionality to ActiveRecord models}
  gem.description = %q{acts_as_starable is a gem that allows a model to act as a starer of other models or one that can be starred.)}
  gem.license     = 'MIT'

  gem.rubyforge_project = 'acts_as_starable'

  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.require_paths = ['lib']

  #-- development dependencies
  gem.add_development_dependency 'sqlite3'
  gem.add_development_dependency 'rails', '~> 4.0.0'
  gem.add_development_dependency 'factory_girl'
  gem.add_development_dependency 'minitest'
  gem.add_development_dependency 'turn'
end
