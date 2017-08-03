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
  end

  describe 'associations' do
    it { should have_and_belong_to_many :eligibilities}

    it 'returns scoped organizations by eligibility' do
      organization = FactoryGirl.create(:organization, name: "Food Pantry")
      organization2 = FactoryGirl.create(:organization, name: "Women's Shelter")
      eligibility = FactoryGirl.create(:eligibility, name: 'Women')
      organization2.eligibilities.push(eligibility)
      expect(Organization.by_eligibility('Women')).to eq([organization2])

      eligibility2 = FactoryGirl.create(:eligibility, name: 'Low income')
      organization.eligibilities.push(eligibility2)
      expect(Organization.by_eligibility(['Women', 'Low income'])).to eq([ organization2, organization])

    end
  end

  describe '#and_filter' do
    it 'returns only the organizations that match all eligibilities' do
      organization = FactoryGirl.create(:organization, name: "Senior's Center")
      organization2 = FactoryGirl.create(:organization, name: "Women's Shelter")
      organization3 = FactoryGirl.create(:organization, name: "Veteran's Center")
      eligibility = FactoryGirl.create(:eligibility, name: 'Seniors')
      eligibility2 = FactoryGirl.create(:eligibility, name: 'Veterans')
      eligibility3 = FactoryGirl.create(:eligibility, name: 'Women')

      organization.eligibilities.push(eligibility)
      organization2.eligibilities.push(eligibility3)
      organization3.eligibilities.push(eligibility, eligibility2)

      expect(Organization.and_filter(['Seniors', 'Veterans'])).to eq([organization3])
    end
  end
end
