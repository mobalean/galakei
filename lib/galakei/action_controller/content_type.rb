module Galakei
  module ActionController
    # Takes care of ensuring the Content-Type is set to application/xhtml+xml
    # for docomo devices as is required to use xhtml instead of text/html.  If
    # text/html is used, the content is rendered as the vastly inferior i-mode
    # html (aka CHTML).
    module ContentType
      def self.included(klass)
        klass.after_filter :set_xhtml_content_type, :if => :xhtml_content_type_required?
      end

      def xhtml_content_type_required?
        request.docomo? && %r{text/html} =~ response.content_type
      end

      def set_xhtml_content_type
        response.content_type = 'application/xhtml+xml'
      end
    end
  end
end
