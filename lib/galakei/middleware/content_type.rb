module Galakei
  module Middleware
    # Takes care of ensuring the Content-Type is set to application/xhtml+xml
    # for docomo devices as is required to use xhtml instead of text/html.  If
    # text/html is used, the content is rendered as the vastly inferior i-mode
    # html (aka CHTML).
    class ContentType
      def initialize(app)
        @app = app
      end

      def call(env)
        request = Rack::Request.new(env)
        if request.docomo?
          status, headers, response = @app.call(env)
          if headers["Content-Type"]
            headers["Content-Type"].gsub!('text/html', 'application/xhtml+xml') 
          end
          [status, headers, response]
        else
          @app.call(env)
        end
      end
    end
  end
end
