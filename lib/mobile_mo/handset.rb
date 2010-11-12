module MobileMo
  class Handset
    # docomo requires "application/xhtml+xml" content type
    XHTML_CONTENT_TYPE_UA_PATTERNS = [/^DoCoMo\/(\d)/]

    def initialize(request)
      @request = request
    end

    def set_xhtml_content_type?
      XHTML_CONTENT_TYPE_UA_PATTERNS.any? {|p| p =~ @request.user_agent }
    end
  end
end
