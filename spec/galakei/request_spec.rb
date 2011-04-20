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
    before { @request = Rack::Request.new(env_for("Firefox")) }
    it_should_behave_like "non-au devices"
    it_should_behave_like "non-docomo devices"
    it_should_behave_like "non-softbank devices"
    it("should not be galakei") { @request.should_not be_galakei }
  end

  describe "from Docomo SH-06A" do
    before { @request = Rack::Request.new(env_for("Docomo SH-06A")) }
    it_should_behave_like "docomo devices"
    it_should_behave_like "non-au devices"
    it_should_behave_like "non-softbank devices"
  end

  describe "from AU W51SH" do
    before { @request = Rack::Request.new(env_for("AU W51SH")) }
    it_should_behave_like "non-docomo devices"
    it_should_behave_like "non-softbank devices"
    it_should_behave_like "au devices"
    it("should be browser 6") { @request.should be_au_browser_6 }
  end

  describe "from AU W54SH" do
    before { @request = Rack::Request.new(env_for("AU W54SA")) }
    it_should_behave_like "non-docomo devices"
    it_should_behave_like "non-softbank devices"
    it_should_behave_like "au devices"
    it("should not be browser 6") { @request.should_not be_au_browser_6 }
  end

  describe "from Vodafone 802N" do
    before { @request = Rack::Request.new(env_for("Vodafone 802N")) }
    it_should_behave_like "non-au devices"
    it_should_behave_like "non-docomo devices"
    it_should_behave_like "softbank devices"
  end

  describe "from Softbank 709SC" do
    before { @request = Rack::Request.new(env_for("Softbank 709SC")) }
    it_should_behave_like "non-au devices"
    it_should_behave_like "non-docomo devices"
    it_should_behave_like "softbank devices"
  end
end
