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
  end

  describe '#by_eligibility' do
    let(:organization) { FactoryGirl.create(:organization, name: "Food Pantry") }
    let(:organization2) { FactoryGirl.create(:organization, name: "Women's Shelter") }
    let(:eligibility) { FactoryGirl.create(:eligibility, name: 'Women') }

    before do
      organization2.eligibilities.push(eligibility)
    end

    it 'returns scoped organizations by eligibility' do
      expect(Organization.by_eligibility('Women')).to eq([organization2])
    end

    it 'returns all organizations that match either eligibility' do
      eligibility2 = FactoryGirl.create(:eligibility, name: 'Low income')
      organization.eligibilities.push(eligibility2)
      expect(Organization.by_eligibility(['Women', 'Low income'])).to eq([ organization2, organization])
    end

    it 'avoids duplicates for orgs with > 1 filtered eligibility' do
      eligibility2 = FactoryGirl.create(:eligibility, name: 'Low income')
      organization.eligibilities.push(eligibility2)
      organization2.eligibilities.push(eligibility2)

      expect(Organization.by_eligibility(['Women', 'Low income'])).to eq([organization2, organization])
    end
  end

  describe 'Organization#and_filter' do
    let(:organization) { FactoryGirl.create(:organization, name: "Senior's Center") }
    let(:organization2) { FactoryGirl.create(:organization, name: "Women's Shelter") }
    let(:organization3) { FactoryGirl.create(:organization, name: "Veteran's Center") }
    let(:eligibility) { FactoryGirl.create(:eligibility, name: 'Seniors')}
    let(:eligibility2) { FactoryGirl.create(:eligibility, name: 'Veterans') }

    it 'returns only the organizations that match all eligibilities' do
      eligibility3 = FactoryGirl.create(:eligibility, name: 'Women')

      organization.eligibilities.push(eligibility)
      organization2.eligibilities.push(eligibility3)
      organization3.eligibilities.push(eligibility, eligibility2)

      expect(Organization.and_filter(['Seniors', 'Veterans'])).to eq([organization3])
    end

    it 'returns empty array if no orgs match all eligibilities' do
      organization.eligibilities.push(eligibility)
      organization2.eligibilities.push(eligibility2)

      expect(Organization.and_filter(['Seniors', 'Veterans'])).to eq([])
    end

    it 'returns empty if no orgs match all of 3 eligibilities' do
      eligibility3 = FactoryGirl.create(:eligibility, name: 'Women')

      organization.eligibilities.push(eligibility)
      organization2.eligibilities.push(eligibility2)
      organization3.eligibilities.push(eligibility3)

      expect(Organization.and_filter(['Seniors', 'Women', 'Veterans'])).to eq([])
    end
  end

  describe '#has_all_eligibilities' do
    let(:organization) { FactoryGirl.create(:organization, name: "Senior's Center") }
    let(:eligibility) { FactoryGirl.create(:eligibility, name: 'Seniors')}
    let(:eligibility2) { FactoryGirl.create(:eligibility, name: 'Veterans') }
    let(:eligibility3) { FactoryGirl.create(:eligibility, name: "Women") }

    it 'returns true for if an org has all passed eligibilities' do
      organization.eligibilities.push(eligibility, eligibility2, eligibility3)
      expect(organization.has_all_eligibilities([eligibility, eligibility2, eligibility3])).to eq(true)
    end

    it 'returns false if an org only has some passed eligibilities' do
      organization.eligibilities.push(eligibility, eligibility2)
      expect(organization.has_all_eligibilities([eligibility, eligibility2, eligibility3])).to eq(false)
    end
  end

  describe 'Organization#filter' do
    let(:organization) { FactoryGirl.create(:organization, name: "Senior's Center") }
    let(:organization2) { FactoryGirl.create(:organization, name: "Women's Shelter") }
    let(:organization3) { FactoryGirl.create(:organization, name: "Veteran's Center") }
    let(:eligibility) { FactoryGirl.create(:eligibility, name: 'Seniors')}
    let(:eligibility2) { FactoryGirl.create(:eligibility, name: 'Veterans') }
    let(:eligibility3) { FactoryGirl.create(:eligibility, name: "Women") }

    it 'calls *OR* filter for one eligibility' do
      organization.eligibilities.push(eligibility)
      params = { "eligibilities"=>["Seniors"], "filter_type"=>"Accepts any" }

      expect(Organization.filter(params)).to eq([organization])
    end
  end
end
