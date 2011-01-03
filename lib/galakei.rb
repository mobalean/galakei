require 'galakei/railtie' if defined?(Rails)
require 'galakei/request'

module Galakei
  autoload :Email, "galakei/email"
  module ActionController
    autoload :Helper, "galakei/action_controller/helper"
    autoload :Haml, "galakei/action_controller/haml"
    autoload :SessionIdParameter, "galakei/action_controller/session_id_parameter"
  end
  module Filter
    autoload :ContentType, "galakei/filter/content_type"
    autoload :Views, "galakei/filter/views"
  end
end