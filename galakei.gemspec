$:.push File.expand_path("../lib", __FILE__)
require "galakei/version"

Gem::Specification.new do |s|
  s.name         = "galakei"
  s.version      = Galakei::VERSION
  s.platform     = Gem::Platform::RUBY
  s.authors      = ["Paul McMahon", "Michael Reinsch", "Yuki Akamatsu"]
  s.email        = "info@mobalean.com"
  s.homepage     = "http://www.mobalean.com"
  s.summary      = "Japanese feature phones support"
  s.description  = "Japanese feature phones (a.k.a., keitai, galakei) have a number of restrictions over normal web browsers.  This library adds support for them"

  s.files         = `git ls-files`.split("\n")
  s.require_path = 'lib'
  s.rubyforge_project = "galakei"

  s.add_dependency 'actionpack', '>= 3.0.3'
  s.add_dependency 'rack', '>= 1.2.1'
  s.add_dependency 'css_parser'
  s.add_dependency 'nokogiri'
  s.add_dependency 'sanitize'
 
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
end

