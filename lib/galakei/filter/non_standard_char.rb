# coding: utf-8
class Galakei::Filter::NonStandardChar < Galakei::Filter::Base
  def self.inject(klass)
    this_class = self
    klass.after_filter self, :if => lambda {|c| this_class.condition?(c) }
  end  

  def condition?
    response.content_type =~ %r{text/html|application/xhtml+xml}
  end

  def filter
    body = response.body
    full_dot = "\u30FB"
    half_dot = "\uFF65"
    body.gsub!("&middot;", full_dot) if request.docomo?
    body.gsub!("\u00B7",   half_dot) unless request.softbank?
    body.gsub!("&#xFF65;", half_dot) if request.au?
    body.gsub!("&#x30FB;", full_dot) if request.au?
    body.gsub!("&sdot;",   half_dot)
    response.body = body
  end
end
