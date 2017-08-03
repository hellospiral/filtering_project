class Organization < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true

  has_many :locations
  has_and_belongs_to_many :eligibilities

  scope :by_eligibility, ->(eligibility) {  joins(:eligibilities).where(eligibilities: { name: eligibility }).uniq.order(:id) }

  def self.and_filter(eligibilities)
    orgs = self.where(nil)
    eligibilities.each do |ele|
      orgs = orgs.merge(self.by_eligibility(ele))
    end
    orgs
  end

  def self.filter(params)
    if params[:eligibilities]
      if params[:filter_type] == 'Accepts any'
        self.by_eligibility(params[:eligibilities])
      elsif params[:filter_type] == 'Accepts all'
        self.and_filter(params[:eligibilities])
      end
    else
      self.all
    end
  end
end
