class Galakei::Lookup::Railtie < Rails::Railtie # :nodoc:
  initializer "galakei.register.lookup" do
    ActiveSupport.on_load :action_controller do
      include Galakei::Lookup::BrowserDetail
      prepend_view_path ActionView::FileSystemResolver.new(Rails.root.join("app","views"), ":prefix/:action.{:browsers}{.:formats,}{.:handlers,}")
    end
    ActiveSupport.on_load :action_view do
      ActionView::LookupContext.register_detail(:browsers)  { [:full, :smartphone, :galakei] }
    end
  end
end
