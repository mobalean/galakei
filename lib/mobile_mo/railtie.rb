class MobileMo::Railtie < Rails::Railtie
  initializer "mobile_mo.extend.action_controller" do
    ActionController::Base.extend MobileMo::Rails::ClassMethods
  end
  initializer "mobile_mo.include.request" do
    ActionDispatch::Request.send :include, MobileMo::Request
  end
end
