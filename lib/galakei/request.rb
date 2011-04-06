require "rack/request"

module Galakei
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

    def imode_browser_1_0?
      if /docomo(.*\((.*;)?c(\d+)\;)?/i =~ user_agent
        $3.to_i < 500
      else
        false
      end
    end

    def galakei?
      docomo? || au? || softbank?
    end
  end
end

Rack::Request.send :include, Galakei::Request
