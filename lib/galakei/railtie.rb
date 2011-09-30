module Galakei
  class Railtie < ::Rails::Railtie
    config.galakei = ActiveSupport::OrderedOptions.new
    initializer "galakei.extend.action_controller" do |app|
      ActiveSupport.on_load :action_controller do
        include Galakei::HelperMethods
        before_filter Galakei::Filter::Views, :if => :galakei?
        after_filter Galakei::Filter::ContentType, :if => lambda {|c| Galakei::Filter::ContentType.condition?(c) }
        before_filter Galakei::Filter::Recode::Params, :if => lambda {|c| Galakei::Filter::Recode.condition?(c) }
        after_filter Galakei::Filter::Recode::Response, :if => lambda {|c| Galakei::Filter::Recode.condition?(c) }
        after_filter Galakei::Filter::NonStandardChar, :if => lambda {|c| Galakei::Filter::NonStandardChar.condition?(c) }
        after_filter Galakei::Filter::Hankaku, :if => lambda {|c| Galakei::Filter::Hankaku.condition?(c) }
        around_filter Galakei::Filter::Haml, :if => :galakei? if defined?(Haml)
      end
      ActiveSupport.on_load :action_view do
        include Galakei::InputMode
      end
    end
  end
end

require 'galakei/session_id_parameter/railtie'
require 'galakei/docomo_css/railtie'
require 'galakei/email/railtie'
