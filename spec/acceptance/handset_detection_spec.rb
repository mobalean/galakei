# encoding: UTF-8
require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

class HandsetDetectionController < ApplicationController
  def index
    render :inline => <<-ERB
      <% if galakei? %>
        <% if request.docomo? %>
          docomo
        <% elsif request.au? %>
          au
        <% elsif request.softbank? %>
          softbank
        <% end %>
      <% else %>
        not galakei
      <% end %>
    ERB
  end
end

feature 'handset detection' do
  scenario 'for docomo', :driver => :docomo do
    visit '/handset_detection'
    page.body.should match("docomo")
  end

  scenario 'for au', :driver => :au do
    visit '/handset_detection'
    page.body.should match("au")
  end

  scenario 'for softbank', :driver => :softbank do
    visit '/handset_detection'
    page.body.should match("softbank")
  end

  scenario 'for non galakei' do
    visit '/handset_detection'
    page.body.should match("not galakei")
  end
end
