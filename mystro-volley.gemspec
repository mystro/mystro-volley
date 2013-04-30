$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "mystro-volley/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "mystro-volley"
  s.version     = MystroVolley::VERSION
  s.authors     = ["Shawn Catanzarite"]
  s.email       = ["me@shawncatz.com"]
  s.homepage    = "https://github.com/shawncatz/mystro-volley"
  s.summary     = "Volley integration for Mystro Server"
  s.description = "Volley integration for Mystro Server"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.8"
  s.add_dependency "volley"
  s.add_dependency "mongoid"
  # s.add_dependency "jquery-rails"
end
