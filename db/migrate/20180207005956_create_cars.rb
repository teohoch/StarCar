class CreateCars < ActiveRecord::Migration[5.1]
  def change
    create_table :cars do |t|
      t.references :brand, foreign_key: true, null: false
      t.string :model, null: false
      t.string :license_plate, null: false
      t.integer :year
      t.string :color, null: false
      t.float :milage
      t.integer :maintenances
      t.references :fuel, foreign_key: true, null: false
      t.references :transmission, foreign_key: true, null: false
      t.integer :prepaid
      t.integer :reservation_price
      t.string :state
      t.references :branch, foreign_key: true, null: false

      t.timestamps
    end
  end
end
