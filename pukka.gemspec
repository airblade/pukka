# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "pukka/version"

Gem::Specification.new do |s|
  s.name        = "pukka"
  s.version     = Pukka::VERSION
  s.authors     = ["Andy Stewart"]
  s.email       = ["boss@airbladesoftware.com"]
  s.homepage    = ""
  s.summary     = 'A handful of custom ActiveModel validators.'
  s.description = s.summary

  s.rubyforge_project = "pukka"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'activemodel', '~> 3.0'
  s.add_development_dependency 'activesupport', '~> 3.0'
  s.add_development_dependency 'rake', '0.8.7'
end
