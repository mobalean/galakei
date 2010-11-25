class MobileMo::Railtie < Rails::Railtie
  initializer "mobile_mo.extend.action_controller" do
    ActionController::Base.extend MobileMo::Rails::ClassMethods
  end
end
