module Galakei
  class Railtie < ::Rails::Railtie
    config.galakei = ActiveSupport::OrderedOptions.new
    initializer "galakei.extend.action_controller" do |app|
      ActiveSupport.on_load :action_controller do
        include Galakei::HelperMethods
        filters = %w[Views ContentType]
        filters << :Haml if defined?(Haml)
        filters.each {|f| Galakei::Filter.const_get(f).inject(self) }
      end
      ActiveSupport.on_load :action_view do
        include Galakei::InputMode
      end
    end
  end
end

require 'galakei/session_id_parameter/railtie'
require 'galakei/docomo_css/railtie'
