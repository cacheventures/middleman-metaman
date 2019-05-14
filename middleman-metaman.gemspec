# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'middleman-metaman/version'

Gem::Specification.new do |s|
  s.name        = "middleman-metaman"
  s.version     = Middleman::Metaman::VERSION
  s.authors     = ['Jarrett Lusso']
  s.email       = ['jarrett@cacheventures.com']
  s.homepage    = 'https://github.com/cacheventures/middleman-metaman'
  s.summary     = 'Manage your middleman meta tags.'
  s.description = 'Manage your middleman meta tags.'
  s.license     = 'MIT'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency('middleman-core', ['>= 4.2.1'])
end
