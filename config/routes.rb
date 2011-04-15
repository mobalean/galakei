 Rails.application.routes.draw do
   match 'galakei/spacer/:color' => 'galakei/spacer#create', :defaults => { :format => :gif }
 end
