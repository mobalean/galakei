module MobileMo
  module ActionController
    # Set template format to xhtml.  This method of setting the format is rails
    # specific so leave a filter
    module Haml
      def self.included(klass)
        klass.around_filter :switch_haml_to_xhtml, :if => :is_mobile_device?
      end

      def switch_haml_to_xhtml
        logger.debug("switching haml to xhtml")
        old_format = ::Haml::Template.options[:format] 
        ::Haml::Template.options[:format] = :xhtml
        yield
      ensure
        ::Haml::Template.options[:format] = old_format
      end
    end
  end
end
