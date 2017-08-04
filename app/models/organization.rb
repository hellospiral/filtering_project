class Organization < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true

  has_many :locations
  has_and_belongs_to_many :eligibilities

  scope :by_eligibility, ->(eligibility) {  joins(:eligibilities).where(eligibilities: { name: eligibility }).uniq.order(:id) }

  def self.and_filter(eligibilities)
    if eligibilities.length == 1
      Organization.by_eligibility(eligibilities.first)
    elsif eligibilities.length > 1
      orgs = Organization.by_eligibility(eligibilities.first)
      common = []

      (1...eligibilities.length).each do |i|
        new_orgs = Organization.by_eligibility(eligibilities[i])
        new_orgs.each do |org|
          if orgs.include?(org)
            common << org unless common.include?(org)
          end
        end
      end

      common
    else
      raise ArgumentError.new("Must pass at least one eligibility")
    end

    # orgs = self.where(nil)
    # eligibilities.each do |ele|
    #   orgs = orgs.merge(self.by_eligibility(ele))
    # end
    # orgs
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
