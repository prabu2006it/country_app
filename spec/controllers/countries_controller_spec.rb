require 'spec_helper'
require 'rails_helper'
RSpec.describe CountriesController do
  describe "POST import" do
    it "#import" do
      Country.import("public/countries.csv")
      csv_args = {:headers => :first_row, :encoding => "u"}
      expect(Country.count).not_to eq([])
      expect(CSV.foreach("public/countries.csv", csv_args).count).to eq(Country.count)
    end
  end
end