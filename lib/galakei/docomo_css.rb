=begin
== Inlining Styles

=== Basic Inlining

Old docomo handsets {don't support external stylesheets}[http://www.keitai-dev.net/CSS]. Additionally, only very limited CSS is supported. galakei/docomo_css automatically inlines CSS and manipulates markup to overcome these limitations.

 # css file
 h1 { color: red; background-color: blue}

 # source html
 <h1>Foo</h1>

 # outputted html
 <div style="background-color: blue;"><h1><span style="color:red;">Foo</span></h1>/div>

=== Borders

Furthermore, the css border property is supported through the "spacer.gif" technique.

 # css file
 div { border-bottom: 5px solid #000000; }

 # source html
 <div>Foo</div>

 # outputted html
 <div>Foo</div>
 <img src="/galakei/spacer/000000" width="100%" height="5">

This will generate a 1px by 1px image, emulating the effect of borders on old docomo handsets.
=end
module Galakei::DocomoCss
  autoload :Stylesheet, "galakei/docomo_css/stylesheet"
  autoload :InlineStylesheet, "galakei/docomo_css/inline_stylesheet"
end
