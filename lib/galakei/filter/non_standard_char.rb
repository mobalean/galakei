# coding: utf-8
=begin
Each of the following characters has a different unicode values:
  ⋅··∙・•
Some are supported on galakei, but others aren't. The correct version will be used.
=end
class Galakei::Filter::NonStandardChar < Galakei::Filter::Base
  # :stopdoc:
  def condition?
    html_content_type? && (response.charset || Rails.application.config.encoding).downcase == "utf-8"
  end

  def filter
    body = response.body
    full_dot = "\u30FB"
    body.gsub!(/&middot;|&#x30FB;|\u00B7|&#183;|&#xB7;|&#12539;/, full_dot)
    half_dot = "\uFF65"
    body.gsub!(/&#xFF65;|&sdot;|&#x22C5;|&#8901;|&#65381;|\u22C5/, half_dot)
    response.body = body
  end
end
