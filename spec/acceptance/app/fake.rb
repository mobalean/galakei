require 'rails'
require 'active_record'
require 'action_controller/railtie'
require 'action_view/railtie'
require 'galakei/railtie'

# database
ActiveRecord::Base.configurations = {'test' => {:adapter => 'sqlite3', :database => ':memory:'}}
ActiveRecord::Base.establish_connection('test')

# config
app = Class.new(Rails::Application)
app.config.secret_token = "3b7cd727ee24e8444053437c36cc66c4"
app.config.session_store :cookie_store, :key => "_myapp_session"
app.config.active_support.deprecation = :log
app.config.galakei.session_id_parameter = true
app.initialize!

app.routes.draw { match ':controller(/:action(/:id))' }
class ApplicationController < ActionController::Base; end
