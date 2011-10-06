# encoding: UTF-8
require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

class NonStandardCharController < ApplicationController
  def self.character(name, value, options = {})
    define_method("#{name}_raw") do
      render :inline => "'#{value}'"
    end
    define_method("#{name}_dec") do
      render :inline => "'&##{value.codepoints.first.to_s};'"
    end
    define_method("#{name}_hex") do
      render :inline => "'&#x#{value.codepoints.first.to_s(16).upcase};'"
    end
    if options[:named]
      define_method("#{name}_named") do
        render :inline => "'&#{name};'"
      end
    end
  end

  character :middot, "\u00B7", named: true
  character :nakaguro_half, "\uFF65"
  character :nakaguro_full, "\u30FB"
  character :sdot, "\u22C5", named: true
end

shared_examples_for "convert character" do |type, path|
  %w[au docomo softbank].each do |driver|
    scenario "should convert #{path} to #{type} for #{driver}", :driver => driver.to_sym do
      visit "/non_standard_char/#{path}"
      page.source =~ /'(.*)'/
      $1.codepoints.first.should == (type == :full ? 12539 : 65381)
    end
  end
end

feature 'nakaguro' do
  it_should_behave_like "convert character", :full, :middot_raw
  it_should_behave_like "convert character", :full, :middot_hex
  it_should_behave_like "convert character", :full, :middot_dec
  it_should_behave_like "convert character", :full, :middot_named
  it_should_behave_like "convert character", :half, :nakaguro_half_raw
  it_should_behave_like "convert character", :half, :nakaguro_half_hex
  it_should_behave_like "convert character", :half, :nakaguro_half_dec
  it_should_behave_like "convert character", :full, :nakaguro_full_raw
  it_should_behave_like "convert character", :full, :nakaguro_full_hex
  it_should_behave_like "convert character", :full, :nakaguro_full_dec
  it_should_behave_like "convert character", :half, :sdot_raw
  it_should_behave_like "convert character", :half, :sdot_hex
  it_should_behave_like "convert character", :half, :sdot_dec
  it_should_behave_like "convert character", :half, :sdot_named
end
