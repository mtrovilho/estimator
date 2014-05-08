# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'estimator/version'

Gem::Specification.new do |gem|
    gem.name          = 'estimator'
    gem.version       = Estimator::VERSION
    gem.authors       = ['Marcos Trovilho']
    gem.email         = ['marcos@trovilho.com']
    gem.description   = %q{Estimate remaining time based on previous values}
    gem.summary       = %q{Estimate remaining time based on previous values}
    gem.homepage      = 'https://github.com/mtrovilho/estimator'
    gem.license       = 'MIT'

    gem.files         = `git ls-files`.split($/)
    gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
    gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
    gem.require_paths = ['lib']

    gem.add_dependency 'methadone'

    gem.add_development_dependency 'bundler'
    gem.add_development_dependency 'rake'
    gem.add_development_dependency 'rdoc'
    gem.add_development_dependency 'aruba'
end
