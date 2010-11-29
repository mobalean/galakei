module MobileMo
  class Handset
    def initialize(request)
      @request = request
    end

    def set_xhtml_content_type?
      docomo?
    end

    def docomo?
      /DoCoMo/i =~ @request.user_agent
    end

    def au?
      # doesn't detect some 2G phones, but as they will be discontinued soon, doesn't really matter
      /KDDI/ =~ @request.user_agent
    end

    def softbank?
      /^(SoftBank|Vodafone)/ =~ @request.user_agent
    end

    def cookies?
      !pre_2_dot_0_docomo_device?
    end

    def pre_2_dot_0_docomo_device?
      if /docomo(.*\((.*;)?c(\d+)\;)?/i =~ @request.user_agent
        $3.to_i < 500
      else
        false
      end
    end
  end
end