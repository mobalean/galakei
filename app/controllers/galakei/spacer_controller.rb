class Galakei::SpacerController < ApplicationController
  def create
    respond_to do |format|
      format.gif do
        send_data(Galakei::Spacer.create(params[:color]), :disposition => "inline", :type => :gif)
      end
    end
  end
end
