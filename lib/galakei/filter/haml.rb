=begin
haml is great for building galakei sites, as it enforces well formed markup. galakei takes care of setting the haml template format for you, so you'll generate xhtml.
=end
class Galakei::Filter::Haml < Galakei::Filter::Base
  # :stopdoc:
  def filter
    old_format = ::Haml::Template.options[:format]
    Rails.logger.debug("[galakei] galakei detected, switching HAML to use :xhtml")
    ::Haml::Template.options[:format] = :xhtml
    yield
  ensure
    ::Haml::Template.options[:format] = old_format
  end
end
