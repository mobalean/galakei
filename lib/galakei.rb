require 'galakei/railtie' if defined?(Rails)
require 'galakei/request'

module Galakei
  autoload :Email, "galakei/email"
  autoload :HelperMethods, "galakei/helper_methods"
  module Filter
    autoload :Base, "galakei/filter/base"
    autoload :ContentType, "galakei/filter/content_type"
    autoload :Haml, "galakei/filter/haml"
    autoload :Views, "galakei/filter/views"
    autoload :SessionIdParameter, "galakei/filter/session_id_parameter"
  end
end
