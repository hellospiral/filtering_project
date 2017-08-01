class Organization < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true

  has_many :locations
  has_and_belongs_to_many :eligibilities

  scope :by_eligibility, ->(eligibility) {  joins(:eligibilities).where(eligibilities: { name: eligibility })}
end
