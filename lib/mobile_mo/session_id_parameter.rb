module MobileMo::SessionIdParameter
  
  def self.included(klass)
    klass.before_filter :set_session_id_parameter
  end

  protected # the following methods are available within the controller

  def device_needs_session_param_in_url?
    is_mobile_device? && !request.cookies? && session
  end

  def set_session_id_parameter
    key = Rails.application.config.session_options[:key]
    if device_needs_session_param_in_url?
      session[:_dummy_param_to_force_session_init] = nil
      logger.debug("adding session param '#{key}' to default_url_options")
      default_url_options[key] = request.session_options[:id]
    else
      # workaround for issue in rails 3.0.3: default_url_options aren't cleared
      default_url_options.delete(key)
    end
  end
end
