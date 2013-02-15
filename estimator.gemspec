# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'estimator/version'

Gem::Specification.new do |gem|
  gem.name          = "estimator"
  gem.version       = Estimator::VERSION
  gem.authors       = ["Marcos Trovilho"]
  gem.email         = ["marcos@trovilho.com"]
  gem.description   = %q{Estimate remaining time based on previous values}
  gem.summary       = %q{Estimate remaining time based on previous values}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency('methadone', '~> 1.2.4')

  gem.add_development_dependency('rake', '~> 0.9.2')
  gem.add_development_dependency('aruba')
end
