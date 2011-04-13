module Galakei
  module Spacer
    HEX = [
      '47494638396101000100f70000',
      'f'*1530,
      '2c000000000100010000080400010404003b'
    ]

    def self.hex_to_bin(str)
      num = str.size
      raise if num % 2 != 0
      bin = ''
      (num/2).times do |i|
        bin += (str[2 * (i + 1) - 2,2]).hex.chr
      end
      return bin
    end

    def self.create(color = '#ffffff')
      color = '#000000' if color.nil?
      color = color.gsub('#','')
      hex = HEX[0] + color + HEX[1] + HEX[2]
      return hex_to_bin(hex)
    end

    def self.gif(color, options = {})
      width = options[:width] || '100%'
      height = options[:height] || 1
      "<img src='/galakei/spacer/#{color}' width='#{width}' height='#{height}'>"
    end
  end
end
