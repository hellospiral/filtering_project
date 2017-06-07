class Location < ActiveRecord::Base
  belongs_to :organization

  validates :address, :city, :state, :zipcode, presence: true
end
