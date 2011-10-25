require 'bundler'
require 'rspec/core/rake_task'
require 'rdoc/task'
Bundler::GemHelper.install_tasks

task :default => :spec
RSpec::Core::RakeTask.new

RDoc::Task.new :rdoc do |rdoc|
  rdoc.main = "README.rdoc"
  rdoc.title = "Galakei RDoc"
  rdoc.rdoc_files.include("README.rdoc", "lib/**/*.rb")
end
