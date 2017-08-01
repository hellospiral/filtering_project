require "rails_helper"

describe "Editing organizations" do
  scenario "choosing an eligibility for an organizations" do
    organization = FactoryGirl.create(:organization)
    location = FactoryGirl.create(:location, organization: organization)
    eligibility = FactoryGirl.create(:eligibility)

    visit edit_organization_path(organization)

    expect(page).to have_content(eligibility.name)

    check(eligibility.name)
    click_on 'Save'

    expect(page).to have_content(eligibility.name)
    expect(organization.eligibilities).to eq([eligibility])
  end
end
