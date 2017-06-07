class OrganizationDecorator < Draper::Decorator
  delegate_all

  def name
    object.name.titleize
  end
end
