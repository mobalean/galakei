require 'spec_helper'

describe Galakei::EmojiTable do
  before do
    @unicode, @docomo, @softbank, @au = %w[unicode docomo softbank au].map {|s| Galakei::EmojiTable.send(s)}
  end

  it "should handle single-character unicode" do
    @unicode.black_sun_with_rays.should == "&#x2600;"
    @docomo.black_sun_with_rays.should == "&#xE63E;"
    @softbank.black_sun_with_rays.should == "&#xE04A;"
    @au.black_sun_with_rays.should == "&#xE488;"
  end

  it "should handle multi-character unicode" do
    @unicode.hash_key.should == "&#x0023;&#x20E3;"
    @docomo.hash_key.should == "&#xE6E0;"
  end
end
