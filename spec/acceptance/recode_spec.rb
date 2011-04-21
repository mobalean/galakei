# encoding: UTF-8
require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

class RecodeController < ApplicationController
  class << self
    attr_accessor :string
  end

  def index
    render :layout => true, :inline => "Test"
  end

  def new
    render :layout => true, :inline => <<-EOD
    <form action="/recode/create" method="post">
    <input id="string" name="string" type="text">
    <input name="commit" type="submit" value="Submit">
    </form>
    EOD
  end

  def create
    self.class.string = params[:string]
  end
end

feature 'recode' do
  scenario 'au SSL', :driver => :au do
    visit 'https://www.example.com/recode/index'
    page.find(:xpath, '//head/meta')['content'].should == "text/html; charset=Shift_JIS"
  end

  scenario 'post request with Shift JIS data on au SSL', :driver => :au do
    visit 'https://www.example.com/recode/new'
    fill_in 'string', :with => "\x82\xA0"
    click_button "Submit"
    RecodeController.string.should == "あ"
  end

  scenario 'post request with UTF-8 data on au SSL', :driver => :au do
    visit 'https://www.example.com/recode/new'
    fill_in 'string', :with => "あ"
    click_button "Submit"
    RecodeController.string.should_not == "あ"
  end
end
