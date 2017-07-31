require "rails_helper"

describe Eligibility, type: :model do
  describe "validations" do
    it { should have_and_belong_to_many :organizations}
    it { is_expected.to validate_presence_of(:name) }

    it "validates uniqueness of name" do
      eligibility = FactoryGirl.build(:eligibility, name: "Children")
      expect(eligibility).to be_valid

      duplicate_eligibility = FactoryGirl.create(:eligibility, name: "Children")
      expect(eligibility).to_not be_valid
    end
  end
end
