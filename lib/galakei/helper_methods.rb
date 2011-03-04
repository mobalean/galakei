module Galakei
  module HelperMethods
    def self.included(klass)
      klass.helper_method :galakei?
      klass.helper_method :emoji_table
    end

    protected

    def galakei?
      request.galakei?
    end

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
