class Organization < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true

  has_many :locations
  has_and_belongs_to_many :eligibilities

  scope :by_eligibility, ->(eligibility) {  joins(:eligibilities).where(eligibilities: { name: eligibility }).uniq.order(:id) }

  def has_all_eligibilities(eligibilities)

    eligibilities.each do |ele|
      unless self.eligibilities.include?(ele)
        return false
      end
    end
    return true
  end

  def self.and_filter(eligibilities)
    if eligibilities.length == 1
      Organization.by_eligibility(eligibilities.first)
    elsif eligibilities.length > 1
      eligibilities_list = []
      has_all = Organization.none

      eligibilities.each do |ele|
        eligibility = Eligibility.find_by_name(ele)
        eligibilities_list << eligibility
      end

      Organization.by_eligibility(eligibilities).each do |org|
        if org.has_all_eligibilities(eligibilities_list)
          has_all << org
        end
      end

      has_all
    else
      raise ArgumentError.new("Must pass at least one eligibility")
    end
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
