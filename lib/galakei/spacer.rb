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
      hex_color = case @color
                  when 'maroon'; '800000' 
                  when 'red'; 'ff0000' 
                  when 'orange'; 'ffA500'
                  when 'yellow'; 'ffff00' 
                  when 'olive'; '808000'
                  when 'purple'; '800080'
                  when 'fuchsia'; 'ff00ff'
                  when 'white'; 'ffffff'
                  when 'lime'; '00ff00'
                  when 'green'; '008000'
                  when 'navy'; '000080'
                  when 'blue'; '0000ff'
                  when 'aqua'; '00ffff'
                  when 'teal'; '008080'
                  when 'black'; '000000'
                  when 'silver'; 'c0c0c0'
                  when 'gray'; '808080'
                  when 'black'; '000000'
                  else @color
                  end
      HEX[0] + hex_color + HEX[1] + HEX[2]
    end

    def img_tag(options = {})
      width = options[:width] || '100%'
      height = options[:height] || 1
      "<img src='/galakei/spacer/#{@color}' width='#{width}' height='#{height}'>"
    end
  end
end
