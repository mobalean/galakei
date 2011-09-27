# encoding: UTF-8
require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

class NonStandardCharController < ApplicationController
  def middot
    render :inline => '&middot;'
  end

  def latin
    render :inline => "\u00B7"
  end

  def harf_entity
    render :inline => "&#xFF65;"
  end

  def full_entity
    render :inline => "&#x30FB;"
  end

  def sdot
    render :inline => "&sdot;"
  end
end

feature 'nakaguro' do
  scenario "Do convert &middot for docomo", :driver => :docomo  do
    visit '/non_standard_char/middot'
    page.source.should == "\u30FB"
  end

  %w[softbank au].each do |s|
    scenario "Do not convert &middot for #{s}", :driver => s.to_sym do
      visit '/non_standard_char/middot'
      page.source.should == "&middot;"
    end
  end

  %w[au docomo].each do |s|
    scenario "Do convert latin dot(\u00B7) for #{s}", :driver => s.to_sym  do
      visit '/non_standard_char/latin'
      page.source.should == "\uFF65"
    end
  end

  scenario "Do not convert latin dot(\u00B7) for softbank", :driver => :softbank  do
    visit '/non_standard_char/latin'
    page.source.should == "\u00B7"
  end

  %w[softbank docomo].each do |s|
    scenario "Do not convert &#xFF65 for #{s}", :driver => s.to_sym  do
      visit '/non_standard_char/harf_entity'
      page.source.should == "&#xFF65;"
    end
  end

  scenario "Do convert &#xFF65 for au", :driver => :au  do
    visit '/non_standard_char/harf_entity'
    page.source.should == "\uFF65"
  end

  %w[docomo softbank].each do |s|
    scenario "Do not convert &#x30FB for #{s}", :driver => s.to_sym  do
      visit '/non_standard_char/full_entity'
      page.source.should == "&#x30FB;"
    end
  end

  scenario "Do convert &#x30FB for au", :driver => :au  do
    visit '/non_standard_char/full_entity'
    page.source.should == "\u30FB"
  end

  %w[softbank au docomo].each do |s|
    scenario "Do convert &sdot; to \uFF65 for #{s}", :driver => s.to_sym  do
      visit '/non_standard_char/sdot'
      page.source.should == "\uFF65"
    end
  end
end
