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
  %w[softbank au docomo].each do |s|
    scenario "convert &middot to \u30FB for #{s}", :driver => s.to_sym  do
      visit '/non_standard_char/middot'
      page.body.should == "\u30FB"
    end

    scenario "convert latin dot(\u00B7) to \uFF65 for #{s}", :driver => s.to_sym  do
      visit '/non_standard_char/latin'
      page.body.should == "\uFF65"
    end

    scenario "convert entity of harf-size dot to \uFF65 for #{s}", :driver => s.to_sym  do
      visit '/non_standard_char/harf_entity'
      page.body.should == "\uFF65"
    end

    scenario "convert entity of full-size dot to \u30FB for #{s}", :driver => s.to_sym  do
      visit '/non_standard_char/full_entity'
      page.body.should == "\u30FB"
    end

    scenario "convert &sdot; to \uFF65 for #{s}", :driver => s.to_sym  do
      visit '/non_standard_char/sdot'
      page.body.should == "\uFF65"
    end
  end
end
