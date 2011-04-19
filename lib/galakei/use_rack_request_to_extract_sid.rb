require "action_dispatch/middleware/session/abstract_store"

# Patch the abstract session store to accomplish the following things:
#
# - avoid issue https://rails.lighthouseapp.com/projects/8994/tickets/6108-activerecord-session-store-clobbers-params#ticket-6108-2 by using Rack::Request instead of ActionDispatch::Request
# - session ID in the params overwrites session ID in the cookie
# - reset session ID in the cookie if we are on SSL because of AU and SoftBank having different cookies for HTTP and HTTPS.

module ActionDispatch
  module Session
    class AbstractStore
      private
        def extract_session_id(env)
          stale_session_check! do
            request = Rack::Request.new(env)
            if ! @cookie_only && request.params[@key]
              request.cookies[@key] = '' if request.ssl? && request.different_cookie_in_ssl?
              request.params[@key]
            else
              request.cookies[@key]
            end
          end
        end
    end
  end
end
