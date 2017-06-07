require "rails_helper"

describe "Viewing organizations" do
  scenario "viewing all organizations" do
    organization = FactoryGirl.create(:organization)
    location = FactoryGirl.create(:location, organization: organization)
    other_organization = FactoryGirl.create(:organization)

    visit root_path

    expect(page).to have_content(organization.name)
    expect(page).to have_content(other_organization.name)
    expect(page).to have_content(location.address)

    click_link organization.name
    expect(page).to have_content(organization.name)
    expect(page).not_to have_content(other_organization.name)
  end
end
