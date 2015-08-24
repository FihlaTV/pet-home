class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :street
      t.string :city
      t.integer :zipcode
      t.references :post, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
