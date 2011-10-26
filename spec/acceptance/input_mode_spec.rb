# encoding: UTF-8
require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

class InputModeController < ApplicationController
  class User
    extend ActiveModel::Naming
    include ActiveModel::Conversion
    attr_accessor :hiragana, :hankaku_kana, :alphabet, :number_input_mode, :number_type
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
        <%= f.text_field :number_type, :type => "number" %>
      <% end %>
    EOD
  end
end

module InputModeMatchers
  { :hiragana => '-wap-input-format:"*<ja:h>"',
    :hankaku => '-wap-input-format:"*<ja:hk>"',
    :alphabetic => '-wap-input-format:"*<ja:en>"',
    :numeric => '-wap-input-format:"*<ja:n>"'
  }.each do |mode, style|
    define_method("be_docomo_#{mode}") { DocomoInputMode.new style }
  end

  class DocomoInputMode
    def initialize(expected)
      @expected = expected
    end

    def matches?(target)
      @target = target
      @target["style"].eql?(@expected)
    end

    def failure_message_for_should
      "expected #{@target["style"].inspect} to be #{@expected}"
    end

    def failure_message_for_should_not
      "expected #{@target["style"].inspect} not to be #{@expected}"
    end
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
      %w[input_mode type].each do |s|
        page.find("#input_mode_controller_user_number_#{s}").should be_docomo_numeric
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

        %w[input_mode type].each do |s|
          e = page.find("#input_mode_controller_user_number_#{s}")
          e["style"].should == '-wap-input-format:*N'
          e["mode"].should == 'numeric'
          e["istyle"].should == '4'
        end
      end
    end
  end
end
