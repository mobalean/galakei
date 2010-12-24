module MobileMo
  class Railtie < Rails::Railtie
    config.mobile_mo = ActiveSupport::OrderedOptions.new
    config.mobile_mo.session_id_parameter = false
    initializer "mobile_mo.extend.action_controller" do |app|
      ActiveSupport.on_load :action_controller do
        include MobileMo::ActionController::Base
        include MobileMo::ActionController::Haml if defined?(Haml)
        include MobileMo::ActionController::SessionIdParameter if app.config.mobile_mo.session_id_parameter
      end
    end
    initializer "mobile_mo.middleware" do |app|
      app.middleware.use MobileMo::Middleware::ContentType
    end
  end
end
