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
  end
end
