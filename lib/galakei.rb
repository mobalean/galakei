require 'galakei/request'
require 'galakei/docomo_css'
require 'galakei/session_id_parameter'

module Galakei
  autoload :Email, "galakei/email"
  autoload :HelperMethods, "galakei/helper_methods"
  autoload :InputMode, "galakei/input_mode"
  autoload :EmojiTable, "galakei/emoji_table"
  autoload :SessionIdParameterInForm, "galakei/session_id_parameter_in_form"
  autoload :Spacer, "galakei/spacer"
  module Filter # :nodoc:
    autoload :Base, "galakei/filter/base"
    autoload :ContentType, "galakei/filter/content_type"
    autoload :Haml, "galakei/filter/haml"
    autoload :Hankaku, "galakei/filter/hankaku"
    autoload :NonStandardChar, "galakei/filter/non_standard_char"
    autoload :Recode, "galakei/filter/recode"
    autoload :Views, "galakei/filter/views"
  end
end

if defined?(Rails)
  require 'galakei/railtie'
  require 'galakei/engine'
  require 'galakei/use_rack_request_to_extract_sid'
end
