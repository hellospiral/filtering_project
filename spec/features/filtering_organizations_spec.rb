require "rails_helper"

describe "the filtering path" do
  let(:organization) { FactoryGirl.create(:organization, name: "Seniors's Center") }
  let(:organization2) { FactoryGirl.create(:organization, name: "Women's Shelter") }
  let(:organization3) { FactoryGirl.create(:organization, name: "Veteran's Center") }
  let(:eligibility) { FactoryGirl.create(:eligibility, name: "Seniors") }
  let(:eligibility2) { FactoryGirl.create(:eligibility, name: 'Veterans') }
  let(:eligibility3) { FactoryGirl.create(:eligibility, name: 'Women') }

  describe "filtering organizations by eligibility" do
    before do
      organization2.eligibilities.push(eligibility)
      visit root_path
      check "eligibilities[]"
      click_on 'Apply filter'
    end

    it 'displays the name of the organizations matching the checked eligibilities' do
      expect(page).to have_content(organization2.name)
    end

    it "doesn't show the name of organizations that don't match checked eligibilities" do
      expect(page).not_to have_content(organization.name)
    end
  end

  describe 'Filtering organizations with exclusive *AND*' do
    before do
      organization.eligibilities.push(eligibility)
      organization2.eligibilities.push(eligibility3)
      organization3.eligibilities.push(eligibility, eligibility2)
      visit root_path
      find(:css, "#eligibilities_[value='Seniors']").set(true)
      find(:css, "#eligibilities_[value='Veterans']").set(true)
      find(:css, "#filter_type_Accepts_all").set(true)
      click_on 'Apply filter'
    end

    it "displays organizations matching both eligibilities" do
      expect(page).to have_content(organization3.name)
    end

    it "doesn't display organizations that don't match both eligibilities" do
      expect(page).not_to have_content(organization.name)
      expect(page).not_to have_content(organization2.name)
    end


    describe 'matching >2 eligibilities' do
      before do
        organization.eligibilities.push(eligibility2, eligibility3)
        visit root_path
        find(:css, "#eligibilities_[value='Women']").set(true)
        find(:css, "#eligibilities_[value='Seniors']").set(true)
        find(:css, "#eligibilities_[value='Veterans']").set(true)
        find(:css, "#filter_type_Accepts_all").set(true)
        click_on 'Apply filter'
      end

      it 'shows corrent match' do
        expect(page).to have_content(organization.name)
      end

      it "doesn't show incorrect matches" do
        expect(page).not_to have_content(organization2.name)
        expect(page).not_to have_content(organization3.name)
      end

      it "filters out organizations that don't match all eligibilities" do
        eligibility4 = FactoryGirl.create(:eligibility, name: 'Children')
        organization2.eligibilities.push(eligibility4)

        visit root_path
        find(:css, "#eligibilities_[value='Women']").set(true)
        find(:css, "#eligibilities_[value='Children']").set(true)
        find(:css, "#eligibilities_[value='Veterans']").set(true)
        find(:css, "#filter_type_Accepts_all").set(true)
        click_on 'Apply filter'

        expect(page).to have_content("There are no organizations matching your search criteria.")
      end
    end
  end

  it 'remembers selected filters' do
    eligibility = FactoryGirl.create(:eligibility, name: 'Seniors')

    visit root_path
    find(:css, "#eligibilities_[value='Seniors']").set(true)
    click_on 'Apply filter'

    expect(page).to have_checked_field("eligibilities[]")
  end

  it 'informs the user when no matches are found' do
    organization = FactoryGirl.create(:organization, name: "Women's Center")
    eligibility = FactoryGirl.create(:eligibility, name: 'Seniors')

    visit root_path
    expect(page).to have_content(organization.name)
    find(:css, "#eligibilities_[value='Seniors']").set(true)
    click_on 'Apply filter'

    expect(page).to have_no_content(organization.name)
    expect(page).to have_content("There are no organizations matching your search criteria.")
  end
end
