require 'active_support/core_ext/string/output_safety'
module Galakei
  class EmojiTable
    MAPPING = { 
      :black_sun_with_rays => %w[2600 E63E E488 E04A EF60],
      :cloud => %w[2601 E63F E48D E049 EF65],
      :black_telephon => %w[260E E687 E596 E009 F0B3],
      :white_smiling_face => %w[263A E6F0 E4FB E414 EFD4],
      :persevering_face => %w[1F623 E72B EAC2 E406 EC96],
      :left_pointing_magnifying_glass => %w[1F50D E6DC E518 E114 EFF1],
      :envelope => %w[2709 E6D3 E521 E103 EFFA],
      :envelope_with_downwards_arrow_above => %w[1F4E9 E6CF EB62 E103 ED66],
      :footprints => %w[1F463 E698 EB2A E536 ECEB],
      :pencil => %w[270F E719 E4A1 E301 EF79],
      :key => %w[1F511 E6D9 E519 E03F EFF2],
      :alarm_clock => %w[23F0 E6BA E594 E02D F0B1],
      :four_leaf_clover => %w[1F340 E741 E513 E110 EFEC],
      :warning_sign => %w[26A0 E737 E481 E252 EF59],
      :winking_face => %w[1F609 E729 E5C3 E405 F0F3],
      :smiling_face_with_open_mouth => %w[1F603 E6F0 E471 E057 EF49],
      :house_building => %w[1F3E0 E663 E4AB E036 EF84],
      :squared_new => %w[1F195 E6DD E5B5 E212 F0E5],
      :sparkle => %w[2747 E6FA E46C E32E EF44],
      :copyright_sign => %w[00A9 E731 E558 E24E F074],
      :registered_sign => %w[00AE E736 E559 E24F F075],
      :trade_mark_sign => %w[2122 E732 E54E E537 F06A],
      :hash_key => [ %w[0023 20E3] ] + %w[E6E0 EB84 E210 ED89],
      :keycap_1 => [ %w[0031 20E3] ] + %w[E6E2 E522 E21C EFFB],
      :keycap_2 => [ %w[0032 20E3] ] + %w[E6E3 E523 E21D EFFC],
      :keycap_3 => [ %w[0033 20E3] ] + %w[E6E4 E524 E21E F040],
      :keycap_4 => [ %w[0034 20E3] ] + %w[E6E5 E525 E21F F041],
      :keycap_5 => [ %w[0035 20E3] ] + %w[E6E6 E526 E220 F042],
      :keycap_6 => [ %w[0036 20E3] ] + %w[E6E7 E527 E221 F043],
      :keycap_7 => [ %w[0037 20E3] ] + %w[E6E8 E528 E222 F044],
      :keycap_8 => [ %w[0040 20E3] ] + %w[E6E9 E529 E223 F045],
      :keycap_9 => [ %w[0041 20E3] ] + %w[E6EA E52A E224 F046],
      :keycap_0 => [ %w[0030 20E3] ] + %w[E6EB E52C E225 F047],
    }
    class << self
      private
      def pack_as_unicode(a)
        a = [ a ] if a.is_a?(String)
        a.map{|s| ("0x" + s).hex}.pack("U*") 
      end
    end
    MAPPING.each do |k,v|
      define_method k do
        @table[k]
      end
    end

    def initialize(table)
      @table = table
    end

    def self.unicode
      @unicode ||= EmojiTable.new(Hash[MAPPING.map {|k,a| [k, pack_as_unicode(a[0])]}])
    end

    def self.docomo
      @docomo ||= EmojiTable.new(Hash[MAPPING.map {|k,a| [k, pack_as_unicode(a[1])]}])
    end

    def self.au
      @au ||= EmojiTable.new(Hash[MAPPING.map {|k,a| [k, pack_as_unicode(a[4])]}])
    end

    def self.softbank
      @softbank ||= EmojiTable.new(Hash[MAPPING.map {|k,a| [k, pack_as_unicode(a[3])]}])
    end
  end
end
