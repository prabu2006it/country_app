require 'spec_helper'
require 'rails_helper'

RSpec.describe City, type: :model do
  
  describe "City" do
    puts "City rspec called!"
    context "Association" do
      it { is_expected.to belong_to(:country) }
    end
  end
end