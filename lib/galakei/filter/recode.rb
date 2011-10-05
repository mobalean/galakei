# Takes care of recoding pages to Shift-JIS for some handsets when required
require 'nkf'
class Galakei::Filter::Recode < Galakei::Filter::Base
  def self.inject(klass)
    this_class = self
    klass.around_filter self, :if => lambda {|c| this_class.condition?(c) }
  end

  def condition?
    request.ssl? && request.au?
  end

  def filter
    Galakei.logger.info("[galakei] AU handset over SSL detected, recoding everything to Shift_JIS")
    deep_apply(controller.params) do |param|
      NKF.nkf('-Sw', param)
    end
    yield
    doc = Nokogiri::HTML(response.body)
    response.body = doc.serialize(:encoding => 'Shift_JIS')
    response.body = Galakei::EmojiTable.au_utf8_to_sjis(response.body)
    response.charset = "Shift_JIS"
  end

  private
  def deep_apply(obj, &proc)
    case obj
    when Hash
      obj.each_pair do |key, value|
        obj[key] = deep_apply(value, &proc)
      end
    when Array
      obj.collect!{|value| deep_apply(value, &proc)}
    when String
      obj = obj.to_param if obj.respond_to?(:to_param)
      proc.call(obj)
    else
      # NilClass, TrueClass, FalseClass, Tempfile, StringIO, etc...
      return obj
    end
  end
end
