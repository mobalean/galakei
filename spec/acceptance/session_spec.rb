# encoding: UTF-8
require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

class SessionsController < ApplicationController
  class Search
    extend ActiveModel::Naming
    include ActiveModel::Conversion
    attr_accessor :query
    def persisted?; false end
  end

  def new
    session[:foo] = "bar"
    @search = Search.new
    render :inline => <<-EOD
      <%= form_for @search, :url => "/sessions", :html => { :method => :get } do |f| %>"
        <%= f.text_field :query %>
        <%= f.submit %>
      <% end %>
    EOD
  end

  def index
    render :inline => <<-EOD
      Session Data: #{session[:foo]}
      Session Param: #{params.key?(:_myapp_session)}
    EOD
  end
end


feature 'session' do
  scenario 'for au', :driver => :au do
    visit '/sessions/new'
    click_on "Create Search"
    page.should have_content("Session Data: bar")
    page.should have_content("Session Param: false")
  end

  scenario 'for docomo', :driver => :docomo do
    visit '/sessions/new'
    click_on "Create Search"
    page.should have_content("Session Data: bar")
    page.should have_content("Session Param: true")
  end
end
