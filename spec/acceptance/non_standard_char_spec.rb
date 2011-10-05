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

shared_examples_for "convert to full dot" do |driver, path|
  scenario "should convert #{path} for #{driver}", :driver => driver do
    visit "/non_standard_char/#{path}"
    page.source =~ /'(.*)'/
    $1.should == "\u30FB"
  end
end

shared_examples_for "convert to half dot" do |driver, path|
  scenario "should convert #{path} for #{driver}", :driver => driver do
    visit "/non_standard_char/#{path}"
    page.source =~ /'(.*)'/
    $1.should == "\uFF65"
  end
end

shared_examples_for "no conversion" do |driver, path, original|
  scenario "should not convert #{path} for #{driver}", :driver => driver do
    visit "/non_standard_char/#{path}"
    page.source =~ /'(.*)'/
    $1.should == original
  end
end

feature 'nakaguro' do
  it_should_behave_like "no conversion", :au, :middot, "&middot;"
  it_should_behave_like "convert to full dot", :docomo, :middot
  it_should_behave_like "no conversion", :softbank, :middot, "&middot;"

  it_should_behave_like "convert to half dot", :au, :latin
  it_should_behave_like "convert to half dot", :docomo, :latin
  it_should_behave_like "no conversion", :softbank, :latin, "\u00B7"

  it_should_behave_like "convert to half dot", :au, :half_entity
  it_should_behave_like "no conversion", :docomo, :half_entity, "&#xFF65;"
  it_should_behave_like "no conversion", :softbank, :half_entity, "&#xFF65;"

  it_should_behave_like "convert to full dot", :au, :full_entity
  it_should_behave_like "no conversion", :docomo, :full_entity, "&#x30FB;"
  it_should_behave_like "no conversion", :softbank, :full_entity, "&#x30FB;"

  it_should_behave_like "convert to half dot", :au, :sdot
  it_should_behave_like "convert to half dot", :docomo, :sdot
  it_should_behave_like "convert to half dot", :softbank, :sdot
end
