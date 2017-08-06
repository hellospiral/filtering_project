class OrganizationsController < ApplicationController
  def index
    @organizations = Organization.filter(params)
    @eligibilities = Eligibility.all
    @selected = params[:eligibilities]
  end

  def show
    @organization = Organization.find(params[:id]).decorate
  end

  def edit
    @organization = Organization.find(params[:id])
    @eligibilities = Eligibility.all
  end

  def update
    @organization = Organization.find(params[:id])
    respond_to do |format|
      if @organization.update(organization_params)
        format.html { redirect_to organization_path(@organization), notice: 'Organization was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  private

  def organization_params
    params.require(:organization).permit(:name, eligibility_ids: [])
  end
end
