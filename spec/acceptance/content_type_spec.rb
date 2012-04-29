# encoding: UTF-8
require 'acceptance/acceptance_helper'

class ContentTypeController < ApplicationController
  def index
    render :layout => true, :inline => "Test"
  end
end

feature 'content type' do
  %w[au softbank].each do |d|
    scenario d, :driver => d.to_sym do
      visit '/content_type'
      page.response_headers['Content-Type'].should == "text/html; charset=utf-8"
    end
  end
  scenario "docomo", :driver => :docomo do
    visit '/content_type'
    page.response_headers['Content-Type'].should == 'application/xhtml+xml; charset=utf-8'
  end
end

