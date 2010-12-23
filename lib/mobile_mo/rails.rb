module MobileMo::Rails

  module ClassMethods
    def has_mobile_mo(options = {})
      include MobileMo::Rails::InstanceMethods

      helper_method :is_mobile_device?
      helper_method :mobile_subscriber_id

      before_filter :append_mobile_views, :if => :is_mobile_device?
      before_filter :set_xhtml_header, :if => :device_needs_xhtml_content_type?
      if defined?(Haml)
        around_filter :switch_haml_to_xhtml, :if => :is_mobile_device?
      end

      include MobileMo::SessionIdParameter if options[:session_id_parameter]
    end
  end

  module InstanceMethods
    protected

    def is_mobile_device?
      request.is_mobile_device?
    end

    def device_needs_xhtml_content_type?
      request.docomo?
    end

    private

    def append_mobile_views
      logger.debug("appending mobile views")
      prepend_view_path(Rails.root.join('app','views.mobile'))
    end

    def set_xhtml_header
      logger.debug("setting xhtml header")
      response.content_type = 'application/xhtml+xml'
    end

    def switch_haml_to_xhtml
      logger.debug("switching haml to xhtml")
      old_format = Haml::Template.options[:format] 
      Haml::Template.options[:format] = :xhtml
      yield
    ensure
      Haml::Template.options[:format] = old_format
    end
  end
end
