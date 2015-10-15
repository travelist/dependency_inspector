# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dependency_inspector/version'

Gem::Specification.new do |spec|
  spec.name          = 'dependency_inspector'
  spec.version       = DependencyInspector::VERSION
  spec.authors       = ['Komei Shimamura']
  spec.email         = ['komei.t.f@gmail.com']

  spec.summary       = 'Inspect dependency files and retrieve the details'
  spec.description   = ''
  spec.homepage      = 'https://github.com/travelist/dependency_inspector'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(spec)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.8'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rubocop'
end
