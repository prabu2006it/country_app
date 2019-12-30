class Country < ApplicationRecord
  require 'csv'
  require 'open-uri'

  has_many :cities, dependent: :destroy

  def self.import(attachment)
  	csv_args = {:headers => :first_row, :encoding => "u"}
  	is_proper_format = ["city", "country"].collect{|col| CSV.open(attachment, &:readline).include?(col)}.include?(false) ? false : true rescue false
  	if is_proper_format
  	  CSV.foreach(attachment, csv_args) do |value|
  	  	country = Country.find_or_initialize_by(name: value["country"])
  	  	city = country.cities.find_or_initialize_by(name: value["city"])
  	  	city.latitude = value["lat"]
  	  	city.longitude = value["lng"]
  	  	country.save
  	  end
  	end
  end

  def get_valid_country
  	remote_ip = open('http://whatismyip.akamai.com').read
  	geo_ip = Geocoder.search(remote_ip).first if remote_ip.present?
  	geo_country = Geocoder.search(geo_ip.data["loc"]).last if geo_ip.present? and geo_ip.data["loc"].present?
  	return geo_country
  end
end
