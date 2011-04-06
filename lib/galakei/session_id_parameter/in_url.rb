module Galakei::SessionIdParameter::InUrl
  def url_for(options = {})
    if !options.is_a?(Hash) || request.cookies?
      super
    else
      session_opts = request.env[ActionDispatch::Session::AbstractStore::ENV_SESSION_OPTIONS_KEY]
      # if we don't have a session ID yet, create one
      if session_opts[:id].blank?
        # make sure to reset any active record session store,
        # we'll have to create a new one for the new session
        env[ActiveRecord::SessionStore::SESSION_RECORD_KEY] = nil
        # create a new session ID
        session_opts[:id] = ActiveSupport::SecureRandom.hex(8)
      end
      super(options.merge(::Rails.application.config.session_options[:key] => session_opts[:id]))
    end
  end
end
