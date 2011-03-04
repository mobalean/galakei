require "action_dispatch/middleware/session/abstract_store"

module ActionDispatch
  module Session
    class AbstractStore
      private
        def extract_session_id(env)
          stale_session_check! do
            request = Rack::Request.new(env)
            sid = request.cookies[@key]
            sid ||= request.params[@key] unless @cookie_only
            sid
          end
        end
    end
  end
end
