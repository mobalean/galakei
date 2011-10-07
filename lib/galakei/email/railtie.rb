# encoding: UTF-8
class Galakei::Email::Railtie < Rails::Railtie # :nodoc:
  initializer "galakei.register.method.for.mail" do
    ActiveSupport.on_load :action_mailer do
      ActionMailer::Base.register_interceptor Galakei::Email::AuMailInterceptor
    end
  end
end
