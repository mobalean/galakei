# encoding: UTF-8
require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

class InputModeController < ApplicationController
  class User
    extend ActiveModel::Naming
    include ActiveModel::Conversion
    attr_accessor :hiragana, :hankaku_kana, :alphabet, :number_input_mode, :number, :tel, :url, :email, :date, :month, :week, :color, :datetime, :time
    def persisted?; false end
  end
  def index
    @user = User.new
    render :layout => true, :inline => <<-EOD
      <%= form_for @user, :url => "/" do |f| %>"
        <%= f.text_field :hiragana, :inputmode => "hiragana" %>
        <%= f.text_field :hankaku_kana, :inputmode => "hankaku_kana" %>
        <%= f.text_field :alphabet, :inputmode => "alphabet" %>
        <%= f.text_field :number_input_mode, :inputmode => "number" %>
        <% %w[ number tel url email datetime date month week color time ].each do |s| %>
          <%= f.text_field s, :type => s %>
        <% end %>
      <% end %>
    EOD
  end
end

feature 'input mode' do
  include InputModeMatchers
  scenario 'for docomo', :driver => :docomo do
    visit '/input_mode'
    within 'form' do
      find("#input_mode_controller_user_hiragana").should be_docomo_hiragana
      find("#input_mode_controller_user_hankaku_kana").should be_docomo_hankaku
      find("#input_mode_controller_user_alphabet").should be_docomo_alphabetic
      find("#input_mode_controller_user_number_input_mode").should be_docomo_numeric
      %w[url email].each do |s|
        page.find("#input_mode_controller_user_#{s}").should be_docomo_alphabetic
      end
      %w[number tel datetime date month week time color].each do |s|
        page.find("#input_mode_controller_user_#{s}").should be_docomo_numeric
      end
    end
  end

  # Although this markup should work for both au and softbank, since we are
  # dynamicly determining this, perhaps we should just put in appropriate stuff
  %w[au softbank].each do |carrier|
    scenario "for #{carrier}", :driver => carrier.to_sym do
      visit '/input_mode'
      within 'form' do
        e = page.find("#input_mode_controller_user_hiragana")
        e["style"].should == '-wap-input-format:*M'
        e["mode"].should == 'hiragana'
        e["istyle"].should == '1'

        e = page.find("#input_mode_controller_user_hankaku_kana")
        e["style"].should == '-wap-input-format:*M'
        e["mode"].should == 'hankakukana'
        e["istyle"].should == '2'

        e = page.find("#input_mode_controller_user_alphabet")
        e["style"].should == '-wap-input-format:*m'
        e["mode"].should == 'alphabet'
        e["istyle"].should == '3'

        %w[number_input_mode number].each do |s|
          e = page.find("#input_mode_controller_user_#{s}")
          e["style"].should == '-wap-input-format:*N'
          e["mode"].should == 'numeric'
          e["istyle"].should == '4'
        end
      end
    end
  end
end
