require 'test/unit'
require File.join(File.dirname(__FILE__), "../lib/mobile_mo/handset")

class HandsetTest < Test::Unit::TestCase
  class MockRequest
    attr_accessor :user_agent
    def initialize(user_agent)
      @user_agent = user_agent
    end
  end

  def test_set_xhtml_content_type
    assert !handset('Mozilla').set_xhtml_content_type?
    assert handset('DoCoMo/1.0').set_xhtml_content_type?
  end

  private

  def handset(user_agent)
    MobileMo::Handset.new(MockRequest.new(user_agent))
  end
end
