require 'spec_helper'
require 'rails_helper'

RSpec.describe Country, type: :model do
  
  describe "Country" do
    puts "Country rspec called!"
    context "Association" do
      it { is_expected.to have_many(:cities).dependent(:destroy) }
    end

    it "self.import(attachment)" do
      Country.import("public/countries.csv")
      csv_args = {:headers => :first_row, :encoding => "u"}
      expect(CSV.foreach("public/countries.csv", csv_args).count).to eq(Country.count)
      expect(Country.all).not_to eq([])
    end

    it "get_valid_country" do
      country = Country.last 	
      geo_country = country.get_valid_country
      expect(geo_country.country).not_to eq(country.name)
    end    
  end
end