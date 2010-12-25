Gem::Specification.new do |s|
  s.name         = "galakei"
  s.version      = '0.0.1'
  s.platform     = Gem::Platform::RUBY
  s.authors      = ["Paul McMahon", "Michael Reinsch"]
  s.email        = "info@mobalean.com"
  s.homepage     = "http://www.mobalean.com"
  s.summary      = "Handling for Japanese feature phones."
  s.description  = "Japanese feature phones (a.k.a., keitai, galakei) have a number of restrictions over normal web browsers.  This library adds support for them"

  s.files        = Dir.glob("lib/**/*")
  s.require_path = 'lib'
  s.rubyforge_project = '[none]'

  s.add_dependency 'actionpack'
  s.add_dependency 'rack'
end

