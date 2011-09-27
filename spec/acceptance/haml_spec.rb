# encoding: UTF-8
require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

class HamlController < ApplicationController
end

feature 'haml' do
  %w[softbank au docomo].each do |s|
    scenario "for #{s}", :driver => s.to_sym do
      visit '/haml'
      page.source.should include('<br />')
      page.should have_css('br')
    end
  end
end
