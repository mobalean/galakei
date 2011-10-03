if Rails::VERSION::MINOR == 0
# we only need this patch for Rails 3.0, it is fixed in 3.1

require "action_dispatch/middleware/session/abstract_store"

# Patch the abstract session store to accomplish the following things:
#
# - avoid issue https://rails.lighthouseapp.com/projects/8994/tickets/6108-activerecord-session-store-clobbers-params#ticket-6108-2 by using Rack::Request instead of ActionDispatch::Request
# - session ID in the params overwrites session ID in the cookie
# - make sure we always set the session ID in SSL in case the handset uses different cookies for HTTP/HTTPS

module ActionDispatch
  module Session
    class AbstractStore
      private
        def extract_session_id(env)
          stale_session_check! do
            request = Rack::Request.new(env)
            if ! @cookie_only && request.params[@key]
              request.params[@key]
            else
              request.cookies[@key]
            end
          end
        end

        def set_cookie(request, options)
          original_condition = request.cookie_jar[@key] != options[:value] || !options[:expires].nil?
          if original_condition || (request.ssl? && request.different_cookie_in_ssl?)
            request.cookie_jar[@key] = options
          end
        end
    end
  end
end

end
