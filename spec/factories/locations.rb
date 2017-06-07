FactoryGirl.define do
  factory :location do
    organization

    name "Main Office"
    address "1 Main St"
    city "Lexington"
    state "SC"
    zipcode "29208"
  end
end
