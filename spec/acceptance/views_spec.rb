# encoding: UTF-8
require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

class ViewsController < ApplicationController
  def index
  end
end

feature 'View path appending' do
  scenario 'for docomo', :driver => :docomo do
    visit '/views'
  end
end
