module Galakei
  module SessionIdParameter # :nodoc: all
    class Railtie < Rails::Railtie
      config.galakei.session_id_parameter = false
      initializer "galakei.session_id_parameter" do |app|
        if app.config.galakei.session_id_parameter
          require "galakei/session_id_parameter/in_url"
          ActiveSupport.on_load :action_view do
            include Galakei::SessionIdParameter::InForm
          end
        end
      end
    end
  end
end
