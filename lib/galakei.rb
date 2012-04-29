require 'galakei/request'
require 'galakei/docomo_css'
require 'galakei/session_id_parameter'

=begin
== Functionality

* {Convert to and from Shift-JIS when necessary}[rdoc-ref:Galakei::Filter::Recode]
* {Correct Content-Type}[rdoc-ref:Galakei::Filter::ContentType]
* {HTML Email}[rdoc-ref:Galakei::Email]
* {Inlining of CSS}[rdoc-ref:Galakei::DocomoCss]
* {Input Mode Switching}[rdoc-ref:Galakei::InputMode]
* {Maintaining Session}[rdoc-ref:Galakei::SessionIdParameter]
* {Substitution of Unsupported Characters}[rdoc-ref:Galakei::Filter::NonStandardChar]
* {Unicode compatible Emoji}[rdoc-ref:Galakei::HelperMethods#emoji_table]
* {Zenkaku to Hankaku conversion}[rdoc-ref:Galakei::Filter::Hankaku]
* {galakei specific views}[rdoc-ref:Galakei::Filter::Views]
* {haml support}[rdoc-ref:Galakei::Filter::Haml]
=end
module Galakei
  autoload :Email, "galakei/email"
  autoload :HelperMethods, "galakei/helper_methods"
  autoload :InputMode, "galakei/input_mode"
  autoload :EmojiTable, "galakei/emoji_table"
  autoload :SessionIdParameterInForm, "galakei/session_id_parameter_in_form"
  autoload :Spacer, "galakei/spacer"
  autoload :Lookup, "galakei/lookup"
  module Filter # :nodoc:
    autoload :Base, "galakei/filter/base"
    autoload :ContentType, "galakei/filter/content_type"
    autoload :Haml, "galakei/filter/haml"
    autoload :Hankaku, "galakei/filter/hankaku"
    autoload :NonStandardChar, "galakei/filter/non_standard_char"
    autoload :Recode, "galakei/filter/recode"
  end
end

if defined?(Rails)
  require 'galakei/railtie'
  require 'galakei/engine'
  require 'galakei/use_rack_request_to_extract_sid'
end
