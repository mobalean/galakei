module Galakei::SessionIdParameter::InUrl
  def url_for(options = {})
    return super unless inject_session_id_parameter?(options)
    session_opts = request.env[ActionDispatch::Session::AbstractStore::ENV_SESSION_OPTIONS_KEY]
    # if we don't have a session ID yet, create one
    if session_opts[:id].blank?
      # make sure to reset any active record session store,
      # we'll have to create a new one for the new session
      request.env[ActiveRecord::SessionStore::SESSION_RECORD_KEY] = nil
      # create a new session ID
      session_opts[:id] = ActiveSupport::SecureRandom.hex(8)
    end
    super(options.merge(::Rails.application.config.session_options[:key] => session_opts[:id]))
  end

  private

  def inject_session_id_parameter?(options)
    return false unless options.is_a?(Hash) && request
    return true if request.imode_browser_1_0?

    # au and softbank have two forms of cookies depending on if it is
    # http or https, so carry over session id when switching protocols
    return false unless options[:protocol]
    request.different_cookie_in_ssl? && (request.protocol != options[:protocol])
  end
end
