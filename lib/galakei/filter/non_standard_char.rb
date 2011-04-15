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
    response.body = response.body.gsub(/・/,'&middot;')
  end
end
