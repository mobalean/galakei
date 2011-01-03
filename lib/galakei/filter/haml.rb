module Galakei
  module Filter
    # Set template format to xhtml.  This method of setting the format is rails
    # specific so leave a filter
    class Haml
      def self.inject(klass)
        klass.around_filter self.new, :if => :galakei?
      end

      def around(controller)
        controller.logger.debug("switching haml to xhtml")
        old_format = ::Haml::Template.options[:format] 
        ::Haml::Template.options[:format] = :xhtml
        yield
      ensure
        ::Haml::Template.options[:format] = old_format
      end
    end
  end
end
