module Galakei
=begin
Old docomo handsets {don't support cookies}[http://www.keitai-dev.net/Cookies]. Furthermore, although Softbank and Au handsets support cookies, when accessing SSL pages, different cookies may be used. Galakei works around this by injecting a session id parameter into your URLs and forms (as long as you use a standard rails method for creating them). To enable this functionality, you will need to modify your session_store.rb initializer to allow the use of session parameters and use a non cookie-based store.

  MyApp::Application.config.session_store :active_record_store, :key => '_sid', :cookie_only => false

You'll also need to enable this option in galakei

  config.galakei.session_id_parameter = true
=end
  module SessionIdParameter
    autoload :InForm, "galakei/session_id_parameter/in_form"
    autoload :InUrl, "galakei/session_id_parameter/in_url"
  end
end
