# Set template format to xhtml.  This method of setting the format is rails
# specific so leave a filter
class Galakei::Filter::Haml < Galakei::Filter::Base
  def self.inject(klass)
    klass.around_filter self, :if => :galakei?
  end

  def filter
    old_format = ::Haml::Template.options[:format] 
    ::Haml::Template.options[:format] = :xhtml
    yield
  ensure
    ::Haml::Template.options[:format] = old_format
  end
end
