class Galakei::SpacerController < ActionController::Base
  def create
    respond_to do |format|
      format.gif do
        send_data(Galakei::Spacer.create_gif(params[:color]), :disposition => "inline", :type => :gif)
      end
    end
  end
end
