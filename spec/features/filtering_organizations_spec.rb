require "rails_helper"

describe "Filtering organizations" do
  scenario "filtering organizations by eligibility" do
    organization = FactoryGirl.create(:organization, name: "Women's Shelter")
    organization2 = FactoryGirl.create(:organization, name: "Children's Hospital")
    eligibility = FactoryGirl.create(:eligibility, name: "Youth")
    organization2.eligibilities.push(eligibility)

    visit root_path
    check "eligibilities[]"
    click_on 'Apply filter'
    expect(page).to have_content(organization2.name)
    expect(page).not_to have_content(organization.name)

  end

  scenario "Filtering organization with exclusive *AND*" do
    organization = FactoryGirl.create(:organization, name: "Senior's Center")
    organization2 = FactoryGirl.create(:organization, name: "Women's Shelter")
    organization3 = FactoryGirl.create(:organization, name: "Veteran's Center")
    eligibility = FactoryGirl.create(:eligibility, name: 'Seniors')
    eligibility2 = FactoryGirl.create(:eligibility, name: 'Veterans')
    eligibility3 = FactoryGirl.create(:eligibility, name: 'Women')

    organization.eligibilities.push(eligibility)
    organization2.eligibilities.push(eligibility3)
    organization3.eligibilities.push(eligibility, eligibility2)

    visit root_path
    find(:css, "#eligibilities_[value='Seniors']").set(true)
    find(:css, "#eligibilities_[value='Veterans']").set(true)
    find(:css, "#filter_type_Accepts_all").set(true)
    click_on 'Apply filter'
    expect(page).to have_content(organization3.name)
    expect(page).not_to have_content(organization.name)
    expect(page).not_to have_content(organization2.name)
  end
end
