module Galakei
  module InputMode
    INPUT_MODES = {
      "alphabet" => {
        :docomo_wap_input_format => "en",
        :other_wap_input_format => 'm',
        :mode => 'alphabet',
        :istyle => '3'
      },
      "hiragana" => {
        :docomo_wap_input_format => 'h',
        :other_wap_input_format => 'M',
        :mode => 'hiragana',
        :istyle => '1'
      },
      "hankaku_kana" => {
        :docomo_wap_input_format => 'hk',
        :other_wap_input_format => 'M',
        :mode => 'hankakukana',
        :istyle => '2'
      },
      "number" => {
        :docomo_wap_input_format => 'n',
        :other_wap_input_format => 'N',
        :mode => 'numeric',
        :istyle => '4'
      }
    }

    def text_field(object_name, method, options = {})
      if request.galakei?
        inputmode = if options[:type] == "number"
          options.delete(:type)
        else
          options.delete(:inputmode)
        end
        if inputmode = INPUT_MODES[inputmode]
          if request.docomo?
            style = inputmode[:docomo_wap_input_format]
            options[:style] = %Q{-wap-input-format:"*<ja:#{style}>"}
          else
            options[:istyle] = inputmode[:istyle]
            options[:mode] = inputmode[:mode]
            options[:style] ||= %Q{-wap-input-format:*#{inputmode[:other_wap_input_format]}}
          end
        end
      end
      super(object_name, method, options)
    end
  end
end
