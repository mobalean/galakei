class Galakei::SpacerController < ApplicationController
  def create
    respond_to do |format|
      format.gif do
        send_data(Galakei::Spacer.new(params[:color]).create, :disposition => "inline", :type => :gif)
      end
    end
  end
end
