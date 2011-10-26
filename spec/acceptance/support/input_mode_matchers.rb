module InputModeMatchers
  { :hiragana => '-wap-input-format:"*<ja:h>"',
    :hankaku => '-wap-input-format:"*<ja:hk>"',
    :alphabetic => '-wap-input-format:"*<ja:en>"',
    :numeric => '-wap-input-format:"*<ja:n>"'
  }.each do |mode, style|
    define_method("be_docomo_#{mode}") { DocomoInputMode.new style }
  end

  class DocomoInputMode
    def initialize(expected)
      @expected = expected
    end

    def matches?(target)
      @target = target
      @target["style"].eql?(@expected)
    end

    def failure_message_for_should
      "expected #{@target.native} to have style='#{@expected}'"
    end

    def failure_message_for_should_not
      "expected #{@target.native} not to have style='#{@expected}'"
    end
  end
end

