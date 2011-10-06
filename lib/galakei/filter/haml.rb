# Set template format to xhtml.  This method of setting the format is rails
# specific so leave a filter
class Galakei::Filter::Haml < Galakei::Filter::Base
  def filter
    old_format = ::Haml::Template.options[:format]
    Rails.logger.debug("[galakei] galakei detected, switching HAML to use :xhtml")
    ::Haml::Template.options[:format] = :xhtml
    yield
  ensure
    ::Haml::Template.options[:format] = old_format
  end
end
