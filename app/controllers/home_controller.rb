class HomeController < ActionController::Base
  layout "application"

  def index 
  	@cities = City.includes(:country).order(:updated_at).paginate(page: params[:page], per_page: 10)
  end

end
