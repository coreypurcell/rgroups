# -*- encoding: utf-8 -*-
require_relative "lib/rgroups/version"

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

  s.require_path = "lib"

  # specify any dependencies here; for example:
  s.add_development_dependency "rake"
end
