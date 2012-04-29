module Galakei
=begin
In many cases you want to serve different templates for galakei handsets. Galakei registeres a browser detail for lookup, so you can use ":prefix/:action.{:browsers}{.:formats,}{.:handlers,}" for your templates.

For instance: index.galakei.html.haml will be used (if present) for galakei and index.full.html.haml will be used for full featured browsers. If not present, it will use the usual templates.

=end
  module Lookup
    autoload :BrowserDetail, "galakei/lookup/browser_detail"
  end
end
