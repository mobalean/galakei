require "rack/request"

module MobileMo
  module Request
    def docomo?
      /DoCoMo/i =~ user_agent
    end

    def au?
      # doesn't detect some 2G phones, but as they will be discontinued soon, doesn't really matter
      /KDDI/ =~ user_agent
    end

    def softbank?
      /^(SoftBank|Vodafone)/ =~ user_agent
    end

    def cookies?
      !imode_browser_1_0?
    end

    def imode_browser_1_0?
      if /docomo(.*\((.*;)?c(\d+)\;)?/i =~ user_agent
        $3.to_i < 500
      else
        false
      end
    end

    def is_mobile_device?
      docomo? || au? || softbank?
    end
  end
end

Rack::Request.send :include, MobileMo::Request
