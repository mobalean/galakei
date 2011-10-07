module Galakei # :nodoc: all
  module DocomoCss
    class Railtie < Rails::Railtie
      initializer "galakei.docomo_css" do |app|
        ActiveSupport.on_load :action_controller do
          after_filter Galakei::DocomoCss::InlineStylesheet
        end
      end
    end
  end
end
