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

  s.rubyforge_project = "rgroups"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
end
