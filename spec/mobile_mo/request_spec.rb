require 'spec_helper'

%w[docomo au softbank].each do |carrier|
  shared_examples_for "non-#{carrier} devices" do
    it("should not be #{carrier}?") do
      @request.should_not send("be_#{carrier}")
    end
  end
  shared_examples_for "#{carrier} devices" do
    it("should be #{carrier}?") do
      @request.should send("be_#{carrier}")
    end
    it("should be mobile") { @request.should be_is_mobile_device }
  end
end

describe MobileMo::Request do
  describe "from Firefox" do
    before { @request = Rack::Request.new("HTTP_USER_AGENT" => "Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.1.16) Gecko/20101130 Firefox/3.5.16") }
    it_should_behave_like "non-au devices"
    it_should_behave_like "non-docomo devices"
    it_should_behave_like "non-softbank devices"
    it("should not be mobile") { @request.should_not be_is_mobile_device }
  end

  describe "from Docomo SH-06A" do
    before { @request = Rack::Request.new("HTTP_USER_AGENT" => "DoCoMo/2.0 SH06A3(c500;TB;W24H14)") }
    it_should_behave_like "docomo devices"
    it_should_behave_like "non-au devices"
    it_should_behave_like "non-softbank devices"
  end

  describe "from AU W51SH" do
    before { @request = Rack::Request.new("HTTP_USER_AGENT" => "KDDI-SH32 UP.Browser/6.2.0.11.2.1 (GUI) MMP/2.0") }
    it_should_behave_like "non-docomo devices"
    it_should_behave_like "non-softbank devices"
  end

  describe "from Vodaphone 802N" do
    before { @request = Rack::Request.new("HTTP_USER_AGENT" => "Vodafone/1.0/V802N/NJ001/SN*************** Browser/UP.Browser/7.0.2.1.307 Profile/MIDP-2.0 Configuration/CLDC-1.1 Ext-J-Profile/JSCL-1.2.2 Ext-V-Profile/VSCL-2.0.0") }
    it_should_behave_like "non-au devices"
    it_should_behave_like "non-docomo devices"
    it_should_behave_like "softbank devices"
  end

  describe "from Softbank 709SC" do
    before { @request = Rack::Request.new("HTTP_USER_AGENT" => "SoftBank/1.0/709SC/SCJ001/SN*************** Browser/NetFront/3.3 Profile/MIDP-2.0 Configuration/CLDC-1.1") }
    it_should_behave_like "non-au devices"
    it_should_behave_like "non-docomo devices"
    it_should_behave_like "softbank devices"
  end
end
