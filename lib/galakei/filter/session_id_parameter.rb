class Galakei::Filter::SessionIdParameter < Galakei::Filter::Base
  def self.inject(klass)
    klass.before_filter self
  end

  def filter
    key = ::Rails.application.config.session_options[:key]
    if device_needs_session_param_in_url?
      session_opts = env[ActionDispatch::Session::AbstractStore::ENV_SESSION_OPTIONS_KEY]
      # if we don't have a session ID yet, create one
      if session_opts[:id].blank?
        # make sure to reset any active record session store,
        # we'll have to create a new one for the new session
        env[ActiveRecord::SessionStore::SESSION_RECORD_KEY] = nil
        # create a new session ID
        session_opts[:id] = ActiveSupport::SecureRandom.hex(8)
      end
      sid = session_opts[:id]
      logger.debug("Galakei: adding session param '#{key}' to default_url_options")
      default_url_options[key] = sid
    else
      # default_url_options aren't cleared, so we need to clear them
      default_url_options.delete(key)
    end
  end

  private

  def device_needs_session_param_in_url?
    galakei? && !request.cookies? && session
  end

  def default_url_options
    controller.send :default_url_options
  end

end
