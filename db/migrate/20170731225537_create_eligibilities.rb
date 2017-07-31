class CreateEligibilities < ActiveRecord::Migration
  def change
    create_table :eligibilities do |t|
      t.string :name, null: false
      t.timestamps null: false
    end

    add_index :eligibilities, :name

    create_table :eligibilities_organizations, id: false do |t|
      t.belongs_to :eligibility, index: true
      t.belongs_to :organization, index: true
    end
  end
end
