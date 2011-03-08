# encoding: UTF-8
require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

class SessionsController < ApplicationController
  class Search
    extend ActiveModel::Naming
    include ActiveModel::Conversion
    attr_accessor :query
    def persisted?; false end
  end

  def in_get_form
    session[:previous_page] = "in_get_form"
    @search = Search.new
    render :inline => <<-EOD
      <%= form_for @search, :url => "/sessions", :html => { :method => :get } do |f| %>"
        <%= f.text_field :query %>
        <%= f.submit %>
      <% end %>
    EOD
  end

  def link
    session[:previous_page] = "link"
    render :inline => <<-EOD
      <%= link_to "Link", :action => :index %>
    EOD
  end

  def index
    render :inline => <<-EOD
      Session Data: #{session[:previous_page]}
      Session Param: #{params.key?(:_myapp_session)}
    EOD
  end
end


feature 'session' do
  context 'in get form' do
    scenario 'for au', :driver => :au do
      visit '/sessions/in_get_form'
      click_on "Create Search"
      page.should have_content("Session Data: in_get_form")
      page.should have_content("Session Param: false")
    end

    scenario 'for docomo', :driver => :docomo do
      visit '/sessions/in_get_form'
      click_on "Create Search"
      page.should have_content("Session Data: in_get_form")
      page.should have_content("Session Param: true")
    end
  end

  context 'clicking link' do
    scenario 'for au', :driver => :au do
      visit '/sessions/link'
      click_on "Link"
      page.should have_content("Session Data: link")
      page.should have_content("Session Param: false")
    end

    scenario 'for docomo', :driver => :docomo do
      visit '/sessions/link'
      click_on "Link"
      page.should have_content("Session Data: link")
      page.should have_content("Session Param: true")
    end
  end
end
