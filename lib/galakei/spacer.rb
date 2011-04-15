module Galakei
  class Spacer
    HEX = [
      '47494638396101000100f70000',
      'f'*1530,
      '2c000000000100010000080400010404003b'
    ]

    def initialize(color)
      @color = color.gsub('#','')
    end

    def create
      num = hex.size
      raise 'invalid hex' if num % 2 != 0
      bin = ''
      (num/2).times do |i|
        bin += (hex[2 * (i + 1) - 2,2]).to_i(16).chr
      end
      return bin
    end

    def hex
      HEX[0] + @color + HEX[1] + HEX[2]
    end

    def img_tag(options = {})
      width = options[:width] || '100%'
      height = options[:height] || 1
      "<img src='/galakei/spacer/#{@color}' width='#{width}' height='#{height}'>"
    end
  end
end
