module MobileMo::SessionIdParameter
  
  def self.included(klass)
    klass.before_filter :set_session_id_parameter
  end

  protected # the following methods are available within the controller

  def device_needs_session_param_in_url?
    !handset.cookies? && session
  end

  def set_session_id_parameter
    if device_needs_session_param_in_url?
      session[:_dummy_param_to_force_session_init] = nil
      key = Rails.application.config.session_options[:key]
      logger.debug("adding session param '#{key}' to default_url_options")
      default_url_options[key] = request.session_options[:id]
    end
  end
end
