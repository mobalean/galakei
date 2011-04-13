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
      stylesheet = Galakei::DocomoCss::Stylesheet.new(parser(e['href']))
      stylesheet.apply(doc)
    end
    controller.response.body = doc.to_xhtml(:encoding => doc.encoding)
  end

  private
  def self.parser(href)
    parser = CssParser::Parser.new
    uri = URI.parse(href)
    if uri.host && uri.scheme && uri.port
      parser.load_uri!(uri)
    else
      parser.load_file!(path(href))
    end
    return parser
  end

  def self.path(href)
    base_path = href.gsub(ActionController::Base.asset_host || '', '').gsub(/\?\d+/,'')
    File.join(Rails.root, 'public', base_path)
  end
end
