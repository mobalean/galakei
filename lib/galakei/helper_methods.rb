module Galakei
  module HelperMethods
    include ActionView::Helpers::RawOutputHelper
    def self.included(klass)
      klass.helper_method :galakei?
      klass.helper_method :emoji_table
      klass.helper_method :spacer_gif
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

    def spacer_gif(color, options = {})
      width = options[:width] || 1
      height = options[:height] || 1
      transparent = options[:transparent] || false
      raw "<img src='#{spacer_path(:color => color, :transparent => transparent)}' width = '#{width}' height = '#{height}'/>"
    end
  end
end
