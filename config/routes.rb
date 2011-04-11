 Rails.application.routes.draw do |map|
   match 'spacer' => 'galakei/spacer#create', :format => :gif
 end
