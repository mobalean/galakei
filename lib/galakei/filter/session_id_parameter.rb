class Galakei::Filter::SessionIdParameter < Galakei::Filter::Base
  def self.inject(klass)
    klass.before_filter self
  end

  def filter
    key = ::Rails.application.config.session_options[:key]
    if device_needs_session_param_in_url?
      session[:_dummy_param_to_force_session_init] = nil
      logger.debug("adding session param '#{key}' to default_url_options")
      default_url_options[key] = request.session_options[:id]
    else
      # workaround for issue in rails 3.0.3: default_url_options aren't cleared
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
