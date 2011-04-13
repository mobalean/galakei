 Rails.application.routes.draw do |map|
   match 'galakei/spacer/:color' => 'galakei/spacer#create', :format => :gif
 end
