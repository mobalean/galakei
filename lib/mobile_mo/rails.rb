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

      before_filter :append_mobile_views
      before_filter :set_xhtml_header
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

    private

    def append_mobile_views
      prepend_view_path("#{RAILS_ROOT}/app/views.mobile") if is_mobile_device?
    end

    def set_xhtml_header
      if is_mobile_device? && handset.set_xhtml_content_type?
        response.content_type = 'application/xhtml+xml'
      end
    end

    def handset
      @handset ||= MobileMo::Handset.new(request)
    end
  end
end
