# encoding: UTF-8
require 'css_parser'
require 'nokogiri'

class Galakei::DocomoCss::InlineStylesheet # :nodoc: all
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
    asset_host = ActionController::Base.asset_host
    # Hack to handle if asset host is a proc. Call it with nil for all arguments.
    if asset_host.respond_to?(:call)
      asset_host = asset_host.call(*asset_host.arity.times.map { nil })
    end
    if /(#{asset_host}|^)\/assets\/([^?]+)/ =~ href
      asset = Rails.application.assets.find_asset($2)
      if asset
        parser.add_block!(asset.to_s, {:media_types => :all, :base_dir => File.dirname(href)})
      else
        Rails.logger.warn("[galakei] asset lookup for #{$2} failed, skipping")
      end
    elsif uri.host && uri.scheme && uri.port && uri.host
      parser.load_uri!(uri)
    else
      parser.load_file!(path(href))
    end
    return parser
  end

  def self.path(href)
    File.join(Rails.root, 'public', href.gsub(/\?\d+/,''))
  end
end
