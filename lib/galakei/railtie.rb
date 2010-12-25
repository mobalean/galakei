module Galakei
  class Railtie < Rails::Railtie
    config.galakei = ActiveSupport::OrderedOptions.new
    config.galakei.session_id_parameter = false
    initializer "galakei.extend.action_controller" do |app|
      ActiveSupport.on_load :action_controller do
        include Galakei::ActionController::Base
        include Galakei::ActionController::Haml if defined?(Haml)
        include Galakei::ActionController::SessionIdParameter if app.config.galakei.session_id_parameter
      end
    end
    initializer "galakei.middleware" do |app|
      app.middleware.use Galakei::Middleware::ContentType
    end
  end
end
