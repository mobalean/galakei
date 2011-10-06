# encoding: UTF-8
require 'css_parser'
require 'nokogiri'

class Galakei::DocomoCss::InlineStylesheet
  def self.filter(controller)
    return unless controller.request.imode_browser_1_0?
    doc = Nokogiri::HTML(controller.response.body)
    stylesheets = doc.xpath('//link[@rel="stylesheet"]')
    return if stylesheets.empty?
    Rails.logger.debug("[galakei] DoCoMo browser 1.0 and external stylesheets detected, inlining CSS")
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
    elsif /^\/assets\/([^?]+)/=~ href
      asset = Rails.application.assets.find_asset($1)
      if asset
        parser.add_block!(asset.to_s, {:media_types => :all, :base_dir => File.dirname(href)})
      else
        Rails.logger.warn("[galakei] asset lookup for #{$1} failed, skipping")
      end
    else
      parser.load_file!(path(href))
    end
    return parser
  end

  def self.path(href)
    File.join(Rails.root, 'public', href.gsub(/\?\d+/,''))
  end
end
