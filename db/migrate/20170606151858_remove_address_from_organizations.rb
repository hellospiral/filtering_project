class RemoveAddressFromOrganizations < ActiveRecord::Migration
  def change
    remove_column :organizations, :address, :string
  end
end
