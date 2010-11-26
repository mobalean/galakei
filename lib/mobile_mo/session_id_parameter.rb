module MobileMo::SessionIdParameter
  
  def self.included(klass)
    klass.before_filter :set_session_id_parameter
  end

  protected # the following methods are available within the controller

  def set_session_id_parameter
    if !handset.cookies? && session
      key = Rails.application.config.session_options[:key]
      default_url_options[key] = request.session_options[:id]
    end
  end
end
