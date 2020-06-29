# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hashtags/version'

Gem::Specification.new do |spec|
  spec.name          = 'hashtags'
  spec.version       = Hashtags::VERSION
  spec.authors       = ['Tomas Celizna']
  spec.email         = ['tomas.celizna@gmail.com']

  spec.summary       = 'Rails engine to facilitate inline text hashtags.'
  spec.homepage      = 'https://github.com/tomasc/hashtags'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'handlebars'
  spec.add_dependency 'rails', '>= 4'
  # spec.add_dependency 'rails-assets-jquery-textcomplete'
  spec.add_dependency 'rails-assets-handlebars'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'guard'
  spec.add_development_dependency 'guard-minitest'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest'

  spec.add_development_dependency 'database_cleaner'
  spec.add_development_dependency 'mongoid', '>= 5.0'
  spec.add_development_dependency 'slim'
end
