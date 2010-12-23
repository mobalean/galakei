class MobileMo::Railtie < Rails::Railtie
  config.mobile_mo = ActiveSupport::OrderedOptions.new
  config.mobile_mo.session_id_parameter = false
  initializer "mobile_mo.extend.action_controller" do |app|
    ActiveSupport.on_load :action_controller do
      include MobileMo::ActionController::Base
      include MobileMo::SessionIdParameter if app.config.mobile_mo.session_id_parameter
    end
  end
  initializer "mobile_mo.include.request" do
    ActionDispatch::Request.send :include, MobileMo::Request
  end
end
