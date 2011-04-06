module Galakei
  module SessionIdParameter
    class Railtie < Rails::Railtie
      config.galakei.session_id_parameter = false
      initializer "galakei.session_id_parameter" do |app|
        if app.config.galakei.session_id_parameter
          Rails.application.routes.url_helpers.class_eval do
            include Galakei::SessionIdParameter::InUrl
          end
          ActiveSupport.on_load :action_view do
            include Galakei::SessionIdParameter::InForm
          end
        end
      end
    end
  end
end
