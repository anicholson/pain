# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pain/version'

Gem::Specification.new do |spec|
  spec.name          = 'pain'
  spec.version       = Pain::VERSION
  spec.authors       = ['Andy Nicholson']
  spec.email         = ['andrew@anicholson.net']
  spec.summary       = %q{Quickly calculate User Pain for a bug}
  spec.description   = %q{Based on http://www.lostgarden.com/2008/05/improving-bug-triage-with-user-pain.html }
  spec.homepage      = 'http://github.com/anicholson/pain.git'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'simplecov-rcov'
  spec.add_development_dependency 'pry'
end
