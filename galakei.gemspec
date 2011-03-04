Gem::Specification.new do |s|
  s.name         = "galakei"
  s.version      = '0.3.0'
  s.platform     = Gem::Platform::RUBY
  s.authors      = ["Paul McMahon", "Michael Reinsch"]
  s.email        = "info@mobalean.com"
  s.homepage     = "http://www.mobalean.com"
  s.summary      = "Japanese feature phones support"
  s.description  = "Japanese feature phones (a.k.a., keitai, galakei) have a number of restrictions over normal web browsers.  This library adds support for them"

  s.files = Dir["LICENSE", "README.md", "lib/**/*"]
  s.require_path = 'lib'
  s.rubyforge_project = '[none]'

  s.add_dependency 'actionpack', '>= 3.0.3'
  s.add_dependency 'rack', '>= 1.2.1'
  s.add_dependency 'docomo_css', '~> 0.4.4'
end

