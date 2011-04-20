# Takes care of recoding pages to Shift-JIS for some handsets when required
class Galakei::Filter::Recode < Galakei::Filter::Base
  def self.inject(klass)
    this_class = self
    klass.after_filter self, :if => lambda {|c| this_class.condition?(c) }
  end

  def condition?
    request.ssl? && request.au_browser_6?
  end

  def filter
    doc = Nokogiri::HTML(response.body)
    response.body = doc.serialize(:encoding => 'Shift_JIS')
    response.charset = "Shift_JIS"
  end
end
