# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "i18n/tools/version"

Gem::Specification.new do |s|
  s.name        = "i18n-tools"
  s.version     = I18n::Tools::VERSION
  s.authors     = ["Bruno Coimbra"]
  s.email       = ["bbcoimbra@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Tools to aid developers to distribute their yaml files among translators.}
  s.description = %q{Tools to aid developers to distribute their yaml files among translators.}

  s.rubyforge_project = "i18n-tools"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rake"
end
