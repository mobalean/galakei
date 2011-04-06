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
    render :layout => true, :inline => <<-EOD
      <%= form_for @search, :url => { :controller => :sessions }, :html => { :method => :get } do |f| %>"
        <%= f.text_field :query %>
        <%= f.submit "in_get_form" %>
      <% end %>
    EOD
  end

  def link
    session[:previous_page] = "link"
    render :layout => true, :inline => <<-EOD
      <%= link_to "link", :action => :index %>
    EOD
  end

  def button_to_get
    session[:previous_page] = "button_to_get"
    render :layout => true, :inline => <<-EOD
      <%= button_to "button_to_get", {:action => :index}, :method => :get %>
    EOD
  end

  def button_to_post
    session[:previous_page] = "button_to_post"
    render :layout => true, :inline => <<-EOD
      <%= button_to "button_to_post", :action => :index %>
    EOD
  end

  def index
    render :layout => true, :inline => <<-EOD
      Session Data: #{session[:previous_page]}
      Session Param: #{params.key?(:_myapp_session)}
    EOD
  end
end


feature 'session' do
  %w[link button_to_post].each do |s|
    context s do
      scenario 'for au', :driver => :au do
        visit "/sessions/#{s}"
        click_on s
        page.should have_content("Session Data: #{s}")
        page.should have_content("Session Param: false")
      end

      scenario 'for docomo', :driver => :docomo do
        visit "/sessions/#{s}"
        click_on s
        page.should have_content("Session Data: #{s}")
        page.should have_content("Session Param: true")
      end
    end
  end

  %w[in_get_form button_to_get].each do |s|
    context s do
      scenario 'for au', :driver => :au do
        visit "/sessions/#{s}"
        click_on s
        page.should have_content("Session Data: #{s}")
        page.should have_content("Session Param: false")
      end

      scenario 'for docomo', :driver => :docomo do
        visit "/sessions/#{s}"
        page.find('form')["action"].should == "/sessions"
        page.find('form input[name="_myapp_session"]')["value"].should_not be_blank
        click_on s
        page.should have_content("Session Data: #{s}")
        page.should have_content("Session Param: true")
      end
    end
  end
end
