# encoding: UTF-8
require 'css_parser'

class Galakei::DocomoCss::InlineStylesheet
  def self.filter(controller)
    return unless controller.request.imode_browser_1_0?
    doc = Nokogiri::HTML(controller.response.body)
    stylesheets = doc.xpath('//link[@rel="stylesheet"]')
    return if stylesheets.empty?
    stylesheets.each do |e|
      e.unlink
      parser = CssParser::Parser.new
      uri = URI.parse(e['href'])
      uri.scheme = controller.request.scheme unless uri.scheme
      uri.host = controller.request.host unless uri.host
      uri.port = controller.request.port unless uri.port
      parser.load_uri!(uri)
      stylesheet = Galakei::DocomoCss::Stylesheet.new(parser)
      stylesheet.apply(doc)
    end
    controller.response.body = doc.to_xhtml(:encoding => doc.encoding)
  end
end
