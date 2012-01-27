require File.expand_path("../lib/omega/hosting/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "omega-hosting"
  s.version     = Omega::Hosting::VERSION
  s.authors     = [""]
  s.email       = [""]
  s.homepage    = "https://github.com/sapresearch/omega-meta/tree/master/omega-hosting"
  s.summary     = ""
  s.description = <<-DESC
DESC

  s.files      = Dir["{app,config,db,lib}/**/*"] + ["Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.1.0"
  s.add_dependency "omega", "~> 1.0.0"

  s.add_development_dependency "sqlite3"
end
