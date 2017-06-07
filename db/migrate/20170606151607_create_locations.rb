class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.belongs_to :organization, null: false
      t.string :name
      t.string :address, null: false
      t.string :city, null: false
      t.string :state, null: false
      t.string :zipcode, null: false

      t.timestamps null: false
    end

    add_index :locations, :organization_id
  end
end
