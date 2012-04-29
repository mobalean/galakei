# encoding: UTF-8
require 'acceptance/acceptance_helper'

class LookupController < ApplicationController
  def index
  end
end

feature 'template lookup' do
  scenario 'full browser' do
    visit '/lookup'
    page.body.should match("full browser")
  end
  scenario 'for docomo', :driver => :docomo do
    visit '/lookup'
    page.body.should match("galakei")
  end
  scenario 'for au', :driver => :au do
    visit '/lookup'
    page.body.should match("galakei")
  end
  scenario 'for softbank', :driver => :softbank do
    visit '/lookup'
    page.body.should match("galakei")
  end
end
