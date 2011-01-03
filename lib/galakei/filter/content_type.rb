module Galakei
  module Filter
    # Takes care of ensuring the Content-Type is set to application/xhtml+xml
    # for docomo devices as is required to use xhtml instead of text/html.  If
    # text/html is used, the content is rendered as the vastly inferior i-mode
    # html (aka CHTML).
    class ContentType
      def self.inject(klass)
        filter = self.new
        klass.after_filter filter, :if => lambda {|c| filter.after_condition?(c) }
      end

      def after_condition?(controller)
        controller.request.docomo? && %r{text/html} =~ controller.response.content_type
      end

      def after(controller)
        controller.response.content_type = 'application/xhtml+xml'
      end
    end
  end
end
