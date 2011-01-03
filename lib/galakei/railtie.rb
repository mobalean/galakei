module Galakei
  class Railtie < Rails::Railtie
    config.galakei = ActiveSupport::OrderedOptions.new
    config.galakei.session_id_parameter = false
    initializer "galakei.extend.action_controller" do |app|
      ActiveSupport.on_load :action_controller do
        include Galakei::ActionController::Helper
        include Galakei::ActionController::Views
        Galakei::Filter::ContentType.inject(self)
        include Galakei::ActionController::Haml if defined?(Haml)
        include Galakei::ActionController::SessionIdParameter if app.config.galakei.session_id_parameter
      end
    end
  end
end
