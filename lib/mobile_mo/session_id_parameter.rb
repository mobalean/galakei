module MobileMo::SessionIdParameter

  protected # the following methods are available within the controller

  def default_url_options(options = nil)
    if is_mobile_device_without_cookie_support? && session
      (super || {}).merge(session_id_parameter_options)
    end
  end

  def is_mobile_device_without_cookie_support?
    pre_2_dot_0_docomo_device?
  end

  private

  def session_id_parameter_options
    { request.session_options[:key] => request.session_options[:id] }
  end

  def pre_2_dot_0_docomo_device?
    if /docomo(.*\((.*;)?c(\d+)\;)?/i =~ request.user_agent
      $3.to_i < 500
    else
      false
    end
  end
end
