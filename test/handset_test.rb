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

  def test_docomo
    assert !handset('Mozilla').docomo?
    assert handset('DoCoMo/1.0').docomo?
  end

  def test_au
    assert !handset('Mozilla').au?
    assert handset('KDDI-SH32 UP.Browser/6.2.0.11.2.1 (GUI) MMP/2.0').au?
  end

  def test_softbank
    assert !handset('Mozilla').softbank?
    assert handset('Vodafone/1.0/V903SH/SHJ001').softbank?
    assert handset('SoftBank/1.0/812SHs/SHJ001').softbank?
  end

  private

  def handset(user_agent)
    MobileMo::Handset.new(MockRequest.new(user_agent))
  end
end
