class Galakei::SpacerController < ApplicationController
  def create
    respond_to do |format|
      color,transparent = params[:color],params[:transparent]
      format.gif {
        send_data(Galakei::Spacer.create(color,transparent), :disposition => "inline", :type => :gif)
      }
    end
  end
end
