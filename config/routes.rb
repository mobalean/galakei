 Rails.application.routes.draw do |map|
   match 'galakei/spacer/:color' => 'galakei/spacer#create', :defaults => { :format => :gif }
 end
