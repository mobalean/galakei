# encoding: UTF-8
require 'acceptance/acceptance_helper'

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

  def secure_link
    render :layout => true, :inline => <<-EOD
      <%= link_to "secure_link", :action => :index, :protocol => "https://" %>
    EOD
  end

  def insecure_link
    render :layout => true, :inline => <<-EOD
      <%= link_to "insecure_link", :action => :index, :protocol => "http://" %>
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

  def session_generation
    render :head => :ok
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

  scenario 'link https to https for au browser 7.2', :driver => :au_7 do
    visit "https://www.example.com/sessions/link"
    click_on 'link'
    page.should have_content("Session Param: false")
  end

  scenario 'link https to https for au browser 6', :driver => :au do
    visit "https://www.example.com/sessions/link"
    click_on 'link'
    page.should have_content("Session Param: true")
  end

  %w[au au_7 softbank].each do |s|
    scenario "link http to https for #{s}", :driver => s.to_sym do
      visit "http://www.example.com/sessions/secure_link"
      click_on 'secure_link'
      page.should have_content("Session Param: true")
    end

    scenario "link https to http for #{s}", :driver => s.to_sym do
      visit "https://www.example.com/sessions/insecure_link"
      click_on 'insecure_link'
      page.should have_content("Session Param: true")
    end
  end

  scenario 'link http to https for docomo_2_0', :driver => :docomo_2_0 do
    visit "http://www.example.com/sessions/secure_link"
    click_on 'secure_link'
    page.should have_content("Session Param: false")
  end

  scenario 'link https to http for docomo_2_0', :driver => :docomo_2_0 do
    visit "https://www.example.com/sessions/insecure_link"
    click_on 'insecure_link'
    page.should have_content("Session Param: false")
  end

  scenario 'route generation in tests' do
    # request is not available in this context
    visit session_generation_path
  end
end
