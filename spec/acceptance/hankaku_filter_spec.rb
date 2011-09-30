# encoding: UTF-8
require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

class HankakuController < ApplicationController
  def index
    render :inline => "<div id='hankaku'>メインガギ漢字ひらがな</div>", :layout => true
  end

  def textarea
    render :inline => "<textarea id='hankaku'>メインガギ漢字ひらがな</textarea>", :layout => true
  end

  def input
    render :inline => "<input id='hankaku' value='メインガギ漢字ひらがな' />", :layout => true
  end
end

feature 'hankaku conversion' do
  shared_examples_for "galakei" do |driver|
    scenario "for #{driver} viewing text", :driver => driver do
      visit '/hankaku'
      page.find("#hankaku").text.should == "ﾒｲﾝｶﾞｷﾞ漢字ひらがな"
    end

    scenario "for #{driver} viewing textarea", :driver => driver do
      visit '/hankaku/textarea'
      page.find("#hankaku").text.should == "メインガギ漢字ひらがな"
    end

    scenario "for #{driver} viewing input", :driver => driver do
      visit '/hankaku/input'
      page.find("#hankaku")["value"].should == "メインガギ漢字ひらがな"
    end
  end
  it_should_behave_like "galakei", :docomo
  it_should_behave_like "galakei", :softbank
  it_should_behave_like "galakei", :au

  scenario 'for PC' do
    visit '/hankaku'
    page.find("#hankaku").text.should == "メインガギ漢字ひらがな"
  end

end
