class CountriesController < ActionController::Base

  layout "application"
  skip_before_action :verify_authenticity_token
  before_action :set_country, only: [:edit]

  def import 
    Country.import(params[:attachment])
  	render :import
  end

  def edit
    geo_country = @country.get_valid_country
    if geo_country.blank?
  	  flash[:error] = "There was some problem is fetching your location."
  	  redirect_to request.referrer
    elsif geo_country.present? and geo_country.country.present? and @country.name == geo_country.country
      render :edit
    else
      flash[:error] = "HEY it looks like you are from #{geo_country.country}"
      redirect_to request.referrer
    end
  end

  private 

  def set_country
  	@country = Country.where(id: params[:id]).last
  end
end
