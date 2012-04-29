require 'spec_helper'

describe Galakei::RouteConstraints::GalakeiOnly do
  describe "from Firefox" do
    let(:req) { Rack::Request.new(env_for_firefox) }
    it { Galakei::RouteConstraints::GalakeiOnly.matches?(req).should be_false }
  end
  describe "from Docomo SH-06A" do
    let(:req) { Rack::Request.new(env_for_docomo_1_0) }
    it { Galakei::RouteConstraints::GalakeiOnly.matches?(req).should be_true }
  end
  describe "from AU W54SH" do
    let(:req) { Rack::Request.new(env_for_au_7_2) }
    it { Galakei::RouteConstraints::GalakeiOnly.matches?(req).should be_true }
  end
  describe "from Vodafone" do
    let(:req) { Rack::Request.new(env_for_vodafone) }
    it { Galakei::RouteConstraints::GalakeiOnly.matches?(req).should be_true }
  end
  describe "from Softbank 709SC" do
    let(:req) { Rack::Request.new(env_for_softbank) }
    it { Galakei::RouteConstraints::GalakeiOnly.matches?(req).should be_true }
  end
end
