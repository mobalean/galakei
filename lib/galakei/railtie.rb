module Galakei
  class Railtie < Rails::Railtie
    config.galakei = ActiveSupport::OrderedOptions.new
    config.galakei.session_id_parameter = false
    initializer "galakei.extend.action_controller" do |app|
      ActiveSupport.on_load :action_controller do
        include Galakei::ActionController::Helper
        Galakei::Filter::Views.inject(self)
        Galakei::Filter::ContentType.inject(self)
        Galakei::Filter::Haml.inject(self) if defined?(Haml)
        Galakei::Filter::SessionIdParameter.inject(self) if app.config.galakei.session_id_parameter
      end
    end
  end
end
