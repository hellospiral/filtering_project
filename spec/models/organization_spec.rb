require "rails_helper"

describe Organization, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }

    it "validates uniqueness of name" do
      organization = FactoryGirl.build(:organization, name: "Food Pantry")
      expect(organization).to be_valid

      duplicate_site = FactoryGirl.create(:organization, name: "Food Pantry")
      expect(organization).to_not be_valid
    end

    it { is_expected.to validate_presence_of(:description) }
    it { should have_and_belong_to_many :eligibilities}
  end
end
