# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rgroups/version"

Gem::Specification.new do |s|
  s.name        = "rgroups"
  s.version     = RGroups::VERSION
  s.authors     = ["Corey Purcell"]
  s.email       = ["corey.purcell@gmail.com"]
  s.homepage    = "https://github.com/coreypurcell/s9-e1"
  s.summary     = %q{A Ruby wrapper for the JGroups Java Toolkit}
  s.description = %q{Using JRuby to provide a ruby interface to the JGroups toolkit.}

  s.required_ruby_version = ">= 1.9.2"

  s.files  = Dir.glob("lib/**/*")
  s.files  += %w(README.md LICENSE rgroups.gemspec)
  s.files  += %w(vendor/jgroups-2.12.1.Final.jar)

  s.require_path = "lib"

  s.add_development_dependency "rake"
  s.add_development_dependency "rspec"
end
