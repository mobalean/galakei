require 'spec_helper'

%w[docomo au softbank].each do |carrier|
  shared_examples_for "non-#{carrier} devices" do
    it("should not be #{carrier}?") do
      should_not send("be_#{carrier}")
    end
  end
  shared_examples_for "#{carrier} devices" do
    it("should be #{carrier}?") do
      should send("be_#{carrier}")
    end
    it("should be galakei") { should be_galakei }
  end
end

describe Galakei::Request do
  describe "from Firefox" do
    subject { Rack::Request.new(env_for_firefox) }
    it_should_behave_like "non-au devices"
    it_should_behave_like "non-docomo devices"
    it_should_behave_like "non-softbank devices"
    it("should not be galakei") { should_not be_galakei }
    it { subject.galakei_uid.should be_nil }
  end

  describe "from Docomo SH-06A" do
    subject { Rack::Request.new(env_for_docomo_1_0) }
    it_should_behave_like "docomo devices"
    it_should_behave_like "non-au devices"
    it_should_behave_like "non-softbank devices"
    it { subject.galakei_uid.should == "0000002" }
  end

  describe "from AU W51SH" do
    subject { Rack::Request.new(env_for_au_6_2) }
    it_should_behave_like "non-docomo devices"
    it_should_behave_like "non-softbank devices"
    it_should_behave_like "au devices"
    it("should be browser 6") { should be_au_browser_6 }
    it { subject.galakei_uid.should == "1234567890_ve.ezweb.ne.jp" }
  end

  describe "from AU W54SH" do
    subject { Rack::Request.new(env_for_au_7_2) }
    it_should_behave_like "non-docomo devices"
    it_should_behave_like "non-softbank devices"
    it_should_behave_like "au devices"
    it("should not be browser 6") { should_not be_au_browser_6 }
    it { subject.galakei_uid.should == "1234567890_ve.ezweb.ne.jp" }
  end

  describe "from Vodafone" do
    subject { Rack::Request.new(env_for_vodafone) }
    it_should_behave_like "non-au devices"
    it_should_behave_like "non-docomo devices"
    it_should_behave_like "softbank devices"
    it { subject.galakei_uid.should == "11111111msimmsim" }
  end

  describe "from Softbank 709SC" do
    subject { Rack::Request.new(env_for_softbank) }
    it_should_behave_like "non-au devices"
    it_should_behave_like "non-docomo devices"
    it_should_behave_like "softbank devices"
    it { subject.galakei_uid.should == "11111111msimmsim" }
  end
end
