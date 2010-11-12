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
    assert !MobileMo::Handset.new(MockRequest.new('Mozilla')).set_xhtml_content_type?
    assert MobileMo::Handset.new(MockRequest.new('DoCoMo/1.0')).set_xhtml_content_type?
  end
end
