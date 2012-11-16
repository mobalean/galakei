require 'rubygems'
require 'bundler/setup'
require 'rails'
Bundler.require(:default, Rails.env)

require 'active_record'
require 'action_controller/railtie'
require 'action_view/railtie'
require 'action_mailer/railtie'
require 'sprockets/railtie'
require 'haml'
require 'galakei/railtie'
require 'galakei/engine'

# config
app = Class.new(Rails::Application)
app.config.root = File.dirname(__FILE__)
app.config.secret_token = "3b7cd727ee24e8444053437c36cc66c4"
app.config.session_store :cookie_store, :key => "_myapp_session"
app.config.active_support.deprecation = :log
app.config.galakei.session_id_parameter = true
app.config.action_mailer.delivery_method = :test
app.config.assets.enabled = true
app.config.assets.version = '1.0'
app.config.assets.compress = false
app.config.assets.digest = true
app.initialize!

app.routes.draw do
  match 'session_generation' => "sessions#session_generation"
  match 'galakei/spacer/:color' => 'galakei/spacer#create', :defaults => { :format => :gif } # should be directly using config/routes
  match ':controller(/:action(/:id))'
end
class ApplicationController < ActionController::Base
  supports_galakei
end
