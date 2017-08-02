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
end
