require 'mobile_mo/railtie' if defined?(Rails)
require 'mobile_mo/request'

module MobileMo
  autoload :Email, "mobile_mo/email"
  module ActionController
    autoload :Base, "mobile_mo/action_controller/base"
    autoload :Haml, "mobile_mo/action_controller/haml"
    autoload :SessionIdParameter, "mobile_mo/action_controller/session_id_parameter"
  end
  module Middleware
    autoload :ContentType, "mobile_mo/middleware/content_type"
  end
end
