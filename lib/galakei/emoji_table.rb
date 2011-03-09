module Galakei
  class EmojiTable
    MAPPING = { 
      :black_sun_with_rays => %w[2600 E63E E488 E04A],
      :cloud => %w[2601 E63F E48D E049],
      :black_telephon => %w[260E E687 E596 E009],
      :white_smiling_face => %w[263A E6F0 E4FB E414],
      :left_pointing_magnifying_glass => %w[1F50D E6DC E518 E114],
      :envelope => %w[2709 E6D3 E521 E103],
      :footprints => %w[1F463 E698 EB2A E536],
      :pencil => %w[270F E719 E4A1 E301],
      :key => %w[1F511 E6D9 E519 E03F],
      :alarm_clock => %w[23F0 E6BA E594 E02D],
      :four_leaf_clover => %w[1F340 E741 E513 E110],
      :warning_sign => %w[26A0 E737 E481 E252],
      :winking_face => %w[1F609 E729 E5C3 E405],
      :smiling_face_with_open_mouth => %w[1F603 E6F0 E471 E057],
      :house_building => %w[1F3E0 E663 E4AB E036]
    }
    MAPPING.each do |k,v|
      MAPPING[k] = v.map {|s| "&#x#{s};".html_safe}
      define_method k do
        MAPPING[k][@carrier]
      end
    end

    def initialize(i)
      @carrier = i
    end

    def self.unicode
      @unicode ||= EmojiTable.new(0)
    end

    def self.docomo
      @docomo ||= EmojiTable.new(1)
    end

    def self.au
      @au ||= EmojiTable.new(2)
    end

    def self.softbank
      @softbank ||= EmojiTable.new(3)
    end
  end
end
