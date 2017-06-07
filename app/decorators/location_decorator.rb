class LocationDecorator < Draper::Decorator
  def address
    "#{object.address}, #{object.city}, #{object.state} #{object.zipcode}"
  end
end
