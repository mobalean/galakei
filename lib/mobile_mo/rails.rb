module MobileMo::Rails

  MOBILE_USER_AGENTS = Regexp.new(
    'palm|palmos|palmsource|blackberry|nokia|symbian|chtml|wml|ericsson|audiovox|motorola|samsung|sanyo|sharp|' +
    'telit|tsm|j2me|sprint|vodafone|docomo|kddi|softbank|pdxgw|j-phone|astel|minimo|plucker|netfront|xiino|' +
    'mot-v|mot-e|portalmmm|sagem|sie-s|sie-m')

  module ClassMethods
    def has_mobile_mo(options = {})
      include MobileMo::Rails::InstanceMethods

      helper_method :is_mobile_device?
      helper_method :mobile_subscriber_id
      helper_method :handset

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

    # Returns either true or false depending on whether or not the user agent of
    # the device making the request is matched to a device in our regex.
    def is_mobile_device?
      @is_mobile_device ||= MobileMo::Rails::MOBILE_USER_AGENTS =~ request.user_agent.to_s.downcase
    end

    def device_needs_xhtml_content_type?
      is_mobile_device? && handset.set_xhtml_content_type?
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

    def handset
      @handset ||= MobileMo::Handset.new(request)
    end
  end
end
