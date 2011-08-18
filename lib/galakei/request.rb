require "rack/request"

module Galakei
  module Request
    def docomo?
      /^DoCoMo/ =~ user_agent
    end

    def au?
      # doesn't detect some 2G phones, but as they will be discontinued soon, doesn't really matter
      /KDDI/ =~ user_agent
    end

    def softbank?
      /^(SoftBank|Vodafone)/ =~ user_agent
    end

    def imode_browser_1_0?
      if /docomo(.*\((.*;)?c(\d+)\;)?/i =~ user_agent
        $3.to_i < 500
      else
        false
      end
    end

    def au_browser_6?
      /KDDI.* UP\.Browser\/6\./ =~ user_agent && /UP\.Browser\/6\.2_7/ !~ user_agent
    end

    def different_cookie_in_ssl?
      au? || softbank?
    end

    def galakei?
      docomo? || au? || softbank?
    end

    def galakei_uid
      if docomo?
        env["HTTP_X_DCMGUID"]
      elsif au?
        env["HTTP_X_UP_SUBNO"]
      elsif softbank?
        env["HTTP_X_JPHONE_UID"]
      end
    end
  end
end

Rack::Request.send :include, Galakei::Request
