module Galakei
  class Railtie < Rails::Railtie
    config.galakei = ActiveSupport::OrderedOptions.new
    config.galakei.session_id_parameter = false
    initializer "galakei.extend.action_controller", :after => "docomo_css.extend.action_controller" do |app|
      ActiveSupport.on_load :action_controller do
        include Galakei::HelperMethods
        docomo_filter
        filters = %w[Views ContentType]
        filters << :Haml if defined?(Haml)
        filters << :SessionIdParameter if app.config.galakei.session_id_parameter
        filters.each {|f| Galakei::Filter.const_get(f).inject(self) }
      end
      ActiveSupport.on_load :action_view do
        include Galakei::InputMode
      end
    end
  end
end
