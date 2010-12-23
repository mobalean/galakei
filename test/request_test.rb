require 'test/unit'
require File.join(File.dirname(__FILE__), "../lib/mobile_mo/request")

class RequestTest < Test::Unit::TestCase
  class MockRequest
    include MobileMo::Request
    attr_accessor :user_agent
    def initialize(user_agent)
      @user_agent = user_agent
    end
  end

  def test_set_xhtml_content_type
    assert !request('Mozilla').set_xhtml_content_type?
    assert request('DoCoMo/1.0').set_xhtml_content_type?
  end

  def test_docomo
    assert !request('Mozilla').docomo?
    assert request('DoCoMo/1.0').docomo?
  end

  def test_au
    assert !request('Mozilla').au?
    assert request('KDDI-SH32 UP.Browser/6.2.0.11.2.1 (GUI) MMP/2.0').au?
  end

  def test_softbank
    assert !request('Mozilla').softbank?
    assert request('Vodafone/1.0/V903SH/SHJ001').softbank?
    assert request('SoftBank/1.0/812SHs/SHJ001').softbank?
  end

  private

  def request(user_agent)
    MockRequest.new(user_agent)
  end
end
