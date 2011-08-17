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
    it("should be galakei") { @request.should be_galakei }
  end
end

describe Galakei::Request do
  describe "from Firefox" do
    before { @request = Rack::Request.new(env_for_firefox) }
    it_should_behave_like "non-au devices"
    it_should_behave_like "non-docomo devices"
    it_should_behave_like "non-softbank devices"
    it("should not be galakei") { @request.should_not be_galakei }
    it { @request.galakei_uid.should be_nil }
  end

  describe "from Docomo SH-06A" do
    before { @request = Rack::Request.new(env_for_docomo_1_0) }
    it_should_behave_like "docomo devices"
    it_should_behave_like "non-au devices"
    it_should_behave_like "non-softbank devices"
    it { @request.galakei_uid.should == "0000002" }
  end

  describe "from AU W51SH" do
    before { @request = Rack::Request.new(env_for_au_6_2) }
    it_should_behave_like "non-docomo devices"
    it_should_behave_like "non-softbank devices"
    it_should_behave_like "au devices"
    it("should be browser 6") { @request.should be_au_browser_6 }
    it { @request.galakei_uid.should == "1234567890_ve.ezweb.ne.jp" }
  end

  describe "from AU W54SH" do
    before { @request = Rack::Request.new(env_for_au_7_2) }
    it_should_behave_like "non-docomo devices"
    it_should_behave_like "non-softbank devices"
    it_should_behave_like "au devices"
    it("should not be browser 6") { @request.should_not be_au_browser_6 }
    it { @request.galakei_uid.should == "1234567890_ve.ezweb.ne.jp" }
  end

  describe "from Vodafone" do
    before { @request = Rack::Request.new(env_for_vodafone) }
    it_should_behave_like "non-au devices"
    it_should_behave_like "non-docomo devices"
    it_should_behave_like "softbank devices"
    it { @request.galakei_uid.should == "11111111msimmsim" }
  end

  describe "from Softbank 709SC" do
    before { @request = Rack::Request.new(env_for_softbank) }
    it_should_behave_like "non-au devices"
    it_should_behave_like "non-docomo devices"
    it_should_behave_like "softbank devices"
    it { @request.galakei_uid.should == "11111111msimmsim" }
  end
end
