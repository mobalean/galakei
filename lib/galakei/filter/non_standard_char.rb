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
    harf_dot = "\uFF65"
    body.gsub!("&middot;", full_dot)
    body.gsub!("\u00B7",   harf_dot)
    body.gsub!("&#xFF65;", harf_dot)
    body.gsub!("&#x30FB;", full_dot)
    body.gsub!("&sdot;",   harf_dot)
    response.body = body
  end
end
