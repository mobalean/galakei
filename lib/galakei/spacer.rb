module Galakei
  module Spacer
    START = '47494638396101000100f70000'
    NOT_INCOLOR = '2c000000000100010000080400010404003b'
    INCOLOR = '21f90401000000002c000000000100010000080400010404003b'
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

    def self.create(color = '#ffffff', incolor = nil)
      color = '#000000' if color.nil?
      color = color.gsub('#','')
      hex = START + color + END_
      if incolor
        hex += INCOLOR
      else
        hex += NOT_INCOLOR
      end
      return hex_to_bin(hex)
    end
  end
end
