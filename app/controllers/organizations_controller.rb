class OrganizationsController < ApplicationController
  def index
    @organizations = Organization.filter(params).includes(:locations)
    @eligibilities = Eligibility.all
    @selected = params[:eligibilities]
  end

  def show
    @organization = Organization.find(params[:id]).decorate
  end

end
