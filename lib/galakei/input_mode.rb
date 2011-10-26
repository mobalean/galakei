=begin
Galakei support switching between different input modes (alphabetic, hiragana, hankaku, and numeric). The input mode will be automatically changed based on the {HTML5 input type}[http://dev.w3.org/html5/spec/Overview.html#attr-input-type]. The following summarizes the mapping:

[alphabetic]  +url+, +email+
[numeric] +tel+, +datetime+, +date+, +month+, +week+, +time+, +number+, +color+

Additionally, the input mode can be explicitly specified by setting the +inputmode+ attribute to one of +alphabet+, +hiragana+, +hankaku_kana+, or +number+.
=end
module Galakei::InputMode
  # :stopdoc:
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
      elsif %w[tel date datetime date month week time color].include?(options[:type])
        options.delete(:type)
        "number"
      elsif %w[email url].include?(options[:type])
        options.delete(:type)
        "alphabet"
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
