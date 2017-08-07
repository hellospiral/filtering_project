class OrganizationsController < ApplicationController
  def index
    @organizations = Organization.filter(params)
    @eligibilities = Eligibility.all
    @selected = params[:eligibilities]
  end

  def show
    @organization = Organization.find(params[:id]).decorate
  end

end
