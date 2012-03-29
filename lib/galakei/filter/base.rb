module Galakei
  module Filter # :nodoc: all
    class Base
      attr_accessor :controller

      def self.condition?(controller)
        @instance ||= self.new
        @instance.controller = controller
        @instance.condition?
      end

      def self.filter(controller, &block)
        @instance ||= self.new
        @instance.controller = controller
        @instance.filter(&block)
      end

      def method_missing(m, *args)
        if controller.respond_to?(m)
          controller.send(m, *args)
        else
          super
        end
      end

      def html_content_type?
        response.content_type =~ %r{text/html|application/xhtml+xml}
      end
    end
  end
end
