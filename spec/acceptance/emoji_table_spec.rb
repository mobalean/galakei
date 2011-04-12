# encoding: UTF-8
require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

class EmojiController < ApplicationController
  def index
    render :inline => "<%= emoji_table.black_sun_with_rays %>", :layout => true
  end
end

feature 'emoji table' do
  scenario 'for docomo', :driver => :docomo do
    visit '/emoji'
    page.body.should match("\uE63E")
  end

  scenario 'for au', :driver => :au do
    visit '/emoji'
    page.body.should match("\uEF60")
  end

  scenario 'for softbank', :driver => :softbank do
    visit '/emoji'
    page.body.should match("\uE04A")
  end

  scenario 'for non galakei' do
    visit '/emoji'
    page.body.should match("\u2600")
  end
end
