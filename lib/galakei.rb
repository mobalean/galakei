require 'galakei/railtie' if defined?(Rails)
require 'galakei/request'

module Galakei
  autoload :Email, "galakei/email"
  module ActionController
    autoload :Helper, "galakei/action_controller/helper"
    autoload :SessionIdParameter, "galakei/action_controller/session_id_parameter"
  end
  module Filter
    autoload :ContentType, "galakei/filter/content_type"
    autoload :Haml, "galakei/filter/haml"
    autoload :Views, "galakei/filter/views"
  end
end
