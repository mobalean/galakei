# Takes care of ensuring the Content-Type is set to application/xhtml+xml
# for docomo devices as is required to use xhtml instead of text/html.  If
# text/html is used, the content is rendered as the vastly inferior i-mode
# html (aka CHTML).
class Galakei::Filter::ContentType < Galakei::Filter::Base
  def self.inject(klass)
    this_class = self
    klass.after_filter self, :if => lambda {|c| this_class.condition?(c) }
  end

  def condition?
    request.docomo? && %r{text/html} =~ response.content_type
  end

  def filter
    Galakei.logger.info("[galakei] DoCoMo browser 1.0 and HTML detected, changing content type to application/xhtml+xml")
    response.content_type = 'application/xhtml+xml'
  end
end
