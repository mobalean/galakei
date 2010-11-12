module MobileMo::SessionIdParameter

  protected # the following methods are available within the controller

  def default_url_options(options = nil)
    if !handset.cookies? && session
      (super || {}).merge(session_id_parameter_options)
    end
  end

  private

  def session_id_parameter_options
    { request.session_options[:key] => request.session_options[:id] }
  end
end
