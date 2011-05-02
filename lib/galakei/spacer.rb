module Galakei
  module Spacer

    GIF_DATA_PREFIX = ['47494638396101000100f70000'].pack('H*')
    GIF_DATA_POSTFIX = ['f'*1530 + '2c000000000100010000080400010404003b'].pack('H*')

    NAMED_COLORS = {
      'maroon' => '800000',
      'red' => 'ff0000',
      'orange' => 'ffA500',
      'yellow' => 'ffff00',
      'olive' => '808000',
      'purple' => '800080',
      'fuchsia' => 'ff00ff',
      'white' => 'ffffff',
      'lime' => '00ff00',
      'green' => '008000',
      'navy' => '000080',
      'blue' => '0000ff',
      'aqua' => '00ffff',
      'teal' => '008080',
      'black' => '000000',
      'silver' => 'c0c0c0',
      'gray' =>'808080',
      'black' => '000000' }

    def self.create_gif(hex_color)
      raise "invalid color" unless /[0-9a-f]{6}/i =~ hex_color
      GIF_DATA_PREFIX + [hex_color].pack('H*') + GIF_DATA_POSTFIX
    end

    def self.img_tag(options = {})
      width = options[:width] || '100%'
      height = options[:height] || 1
      hex_color = color2hex(options[:color])
      "<img src='/galakei/spacer/#{hex_color}' width='#{width}' height='#{height}'>"
    end

    def self.color2hex(color)
      hex_color = NAMED_COLORS[color] || color.gsub('#','').downcase
      hex_color = hex_color.sub(/(.)(.)(.)/, '\1\1\2\2\3\3') if hex_color.size == 3
      hex_color
    end
  end
end
