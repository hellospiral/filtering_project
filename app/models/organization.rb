class Organization < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true

  has_many :locations
  has_and_belongs_to_many :eligibilities

  scope :by_eligibility, ->(eligibility) {  joins(:eligibilities).where(eligibilities: { name: eligibility })}

  def self.and_filter(eligibilities)

    orgs = Organization.where(nil)

    eligibilities.each do |ele|
      orgs = orgs.merge(Organization.by_eligibility(ele))
    end

    orgs
  end
end
