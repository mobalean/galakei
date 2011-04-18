# encoding: UTF-8
require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

class RecodeController < ApplicationController
  def index
    render :layout => true, :inline => "Test"
  end
end

feature 'recode' do
  scenario 'au SSL', :driver => :au do
    visit 'https://www.example.com/recode/index'
    page.find(:xpath, '//head/meta')['content'].should == "text/html; charset=Shift_JIS"
  end
end
