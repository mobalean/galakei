# encoding: UTF-8
require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

class NonStandardCharController < ApplicationController
  [ 
    [ "middot", "&middot;"],
    [ "latin", "\u00B7"],
    [ "half_entity", "&#xFF65;"],
    [ "full_entity", "&#x30FB;"],
    [ "sdot", "&sdot;" ]
  ].each do |m, s|
    define_method(m) do
      render :inline => "'#{s}'"
    end
  end
end

shared_examples_for "convert character" do |type, path|
  %w[au docomo softbank].each do |driver|
    scenario "should convert #{path} to #{type} for #{driver}", :driver => driver.to_sym do
      visit "/non_standard_char/#{path}"
      page.source =~ /'(.*)'/
      $1.should == (type == :full ? "\u30FB" : "\uFF65")
    end
  end
end

feature 'nakaguro' do
  it_should_behave_like "convert character", :full, :middot
  it_should_behave_like "convert character", :half, :latin
  it_should_behave_like "convert character", :half, :half_entity
  it_should_behave_like "convert character", :full, :full_entity
  it_should_behave_like "convert character", :half, :sdot
end
