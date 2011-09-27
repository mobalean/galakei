# encoding: UTF-8
require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

class EmojiController < ApplicationController
  def index
    render :inline => "<%= emoji_table.black_sun_with_rays %>", :layout => true
  end
  def with_unicode
    render :inline => "テスト<%= emoji_table.black_sun_with_rays %>", :layout => true
  end
end

feature 'emoji table' do
  scenario 'for docomo', :driver => :docomo do
    visit '/emoji'
    page.source.should match("\uE63E")
  end

  scenario 'for au', :driver => :au do
    visit '/emoji'
    page.source.should match("\uEF60")
  end

  scenario 'for au SSL', :driver => :au do
    visit 'https://www.example.com/emoji'
    page.source.should match([0xF660].pack("n").force_encoding("Shift_JIS"))
  end

  scenario 'for au SSL with unicode source', :driver => :au do
    visit 'https://www.example.com/emoji/with_unicode'
    expected = "テスト".encode("Shift_JIS") + [0xF660].pack("n").force_encoding("Shift_JIS")
    page.source.should match(expected)
  end

  scenario 'for softbank', :driver => :softbank do
    visit '/emoji'
    page.source.should match("\uE04A")
  end

  scenario 'for non galakei' do
    visit '/emoji'
    page.source.should match("\u2600")
  end
end
