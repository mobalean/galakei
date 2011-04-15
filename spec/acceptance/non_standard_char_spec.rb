# encoding: UTF-8
require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

class NonStandardCharController < ApplicationController
  def index
    render :inline => '・'
  end
end

feature 'nakaguro' do
  %w[softbank au docomo].each do |s|
    scenario "convert nakaguro to &middot;", :driver => s.to_sym  do
      visit '/non_standard_char'
      page.body.should == '&middot;'
    end
  end
end
