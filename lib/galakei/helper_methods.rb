module Galakei
  module HelperMethods
    def self.included(klass) # :nodoc:
      klass.helper_method :galakei?
      klass.helper_method :emoji_table
    end 

    # Does the current request come from a galakei?
    def galakei?
      request.galakei?
    end

    # Returns the carrier specific {Emoji}[http://www.keitai-dev.net/Emoji]. Falls back to Unicode
    # emoji.
    # 
    #   emoji_table.white_smiling_face # "☺"
    def emoji_table
      if request.docomo?
        EmojiTable.docomo
      elsif request.softbank?
        EmojiTable.softbank
      elsif request.au?
        EmojiTable.au
      else
        EmojiTable.unicode
      end
    end
  end
end
