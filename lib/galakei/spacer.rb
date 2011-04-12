module Galakei
  module Spacer
    START = '47494638396101000100f70000'
    NOT_TRANSPARENT = '2c000000000100010000080400010404003b'
    TRANSPARENT = '21f90401000000002c000000000100010000080400010404003b'
    END_ = 'f'*1530

    def self.hex_to_bin(str)
      num = str.size
      raise if num % 2 != 0
      bin = ''
      (num/2).times do |i|
        bin += (str[2 * (i + 1) - 2,2]).hex.chr
      end
      return bin
    end

    def self.create(color = '#ffffff', transparent = false)
      color = '#000000' if color.nil?
      color = color.gsub('#','')
      hex = START + color + END_
      if transparent
        hex += TRANSPARENT
      else
        hex += NOT_TRANSPARENT
      end
      return hex_to_bin(hex)
    end

    def self.gif(color, options = {})
      width = options[:width] || 1
      height = options[:height] || 1
      transparent = options[:transparent] || false
      "<img src='/spacer/create?color=#{color}&transparent=#{transparent}' width = '#{width}' height = '#{height}'/>"
    end
  end
end
