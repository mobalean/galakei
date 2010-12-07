Gem::Specification.new do |s|
  s.name         = "mobile_mo"
  s.version      = '0.2.5'
  s.platform     = Gem::Platform::RUBY
  s.authors      = ["Paul McMahon", "Michael Reinsch"]
  s.email        = "info@mobalean.com"
  s.homepage     = "http://www.mobalean.com"
  s.summary      = "mobile handling"
  s.description  = "mobile handling"

  s.files        = Dir.glob("lib/**/*")
  s.require_path = 'lib'
  s.rubyforge_project = '[none]'

  s.add_dependency 'actionpack'
end

