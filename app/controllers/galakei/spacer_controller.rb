class Galakei::SpacerController < ApplicationController
  def create
    respond_to do |format|
      color,incolor = params[:color],params[:incolor]
      format.gif {
        send_data(Galakei::Spacer.create(color,incolor), :disposition => "inline", :type => :gif)
      }
    end
  end
end
