if defined?(Rails)
  require 'galakei/railtie'
  require 'galakei/use_rack_request_to_extract_sid'
  require 'docomo_css/railtie'
end
require 'galakei/request'

module Galakei
  autoload :Email, "galakei/email"
  autoload :HelperMethods, "galakei/helper_methods"
  autoload :InputMode, "galakei/input_mode"
  autoload :EmojiTable, "galakei/emoji_table"
  autoload :SessionIdParameterInForm, "galakei/session_id_parameter_in_form"
  module Filter
    autoload :Base, "galakei/filter/base"
    autoload :ContentType, "galakei/filter/content_type"
    autoload :Haml, "galakei/filter/haml"
    autoload :Views, "galakei/filter/views"
    autoload :SessionIdParameter, "galakei/filter/session_id_parameter"
  end
  module SessionIdParameter
    autoload :InForm, "galakei/session_id_parameter/in_form"
    autoload :InUrl, "galakei/session_id_parameter/in_url"
  end
end
