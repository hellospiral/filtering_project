class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.string :address, null: false

      t.timestamps null: false
    end
  end
end
