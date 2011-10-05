# coding: utf-8
class Galakei::Filter::NonStandardChar < Galakei::Filter::Base
  def condition?
    response.content_type =~ %r{text/html|application/xhtml+xml} &&
      (response.charset || Rails.application.config.encoding).downcase == "utf-8"
  end

  def filter
    body = response.body
    full_dot = "\u30FB"
    body.gsub!(/&middot;|&#x30FB;/, full_dot)
    half_dot = "\uFF65"
    body.gsub!(/\u00B7|&#xFF65;|&sdot;/, half_dot)
    response.body = body
  end
end
