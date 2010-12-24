require 'mobile_mo/railtie' if defined?(Rails)

module MobileMo
  autoload :Request, "mobile_mo/request"
  autoload :Email, "mobile_mo/email"
  module ActionController
    autoload :Base, "mobile_mo/action_controller/base"
    autoload :Haml, "mobile_mo/action_controller/haml"
    autoload :SessionIdParameter, "mobile_mo/action_controller/session_id_parameter"
  end
end
