# This makes Capybara work with sites that switch between HTTP and HTTPS
# See http://github.com/jnicklas/capybara/issues#issue/85

module Capybara::RackTest::Browser::SslFix

  [:get, :post, :put, :delete].each do |method|
    define_method method do |*args|
      args[0] = path_to_ssl_aware_url(args[0])
      super(*args)
    end
  end

  private

  def path_to_ssl_aware_url(path)
    unless path =~ /:\/\//
      env = request.env
      path = "#{env["rack.url_scheme"]}://#{env["SERVER_NAME"]}#{path}"
    end
    path
  rescue Rack::Test::Error
    # no request yet
    path
  end

end

Capybara::RackTest::Browser.send :include, Capybara::RackTest::Browser::SslFix
