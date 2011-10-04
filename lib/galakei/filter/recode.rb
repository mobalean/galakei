# Takes care of recoding pages to Shift-JIS for some handsets when required
require 'nkf'
module Galakei::Filter::Recode
  def self.inject(klass)
    klass.before_filter Params, :if => lambda {|c| c.request.ssl? && c.request.au? }
    klass.after_filter Response, :if => lambda {|c| c.request.ssl? && c.request.au? }
  end

  class Params < Galakei::Filter::Base
    def filter
      Galakei.logger.info("[galakei] AU handset over SSL detected, recoding everything to Shift_JIS")
      deep_apply(controller.params) do |param|
        NKF.nkf('-Sw', param)
      end
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

  class Response < Galakei::Filter::Base
    def filter
      doc = Nokogiri::HTML(response.body)
      response.body = doc.serialize(:encoding => 'Shift_JIS')
      response.body = Galakei::EmojiTable.au_utf8_to_sjis(response.body)
      response.charset = "Shift_JIS"
    end
  end
end
