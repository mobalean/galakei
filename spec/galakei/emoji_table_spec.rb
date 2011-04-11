require 'spec_helper'

describe Galakei::EmojiTable do
  before do
    @unicode, @docomo, @softbank, @au = %w[unicode docomo softbank au].map {|s| Galakei::EmojiTable.send(s)}
  end

  it "should handle single-character unicode" do
    @unicode.black_sun_with_rays.should == "\u2600"
    @docomo.black_sun_with_rays.should == "\uE63E"
    @softbank.black_sun_with_rays.should == "\uE04A"
    @au.black_sun_with_rays.should == "\uEF60"
  end

  it "should handle multi-character unicode" do
    @unicode.hash_key.should == "\u{0023 20E3}"
    @docomo.hash_key.should == "\uE6E0"
  end
end
