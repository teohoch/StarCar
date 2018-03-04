class CreateCars < ActiveRecord::Migration[5.1]
  def change
    create_table :cars do |t|
      t.references :brand, foreign_key: true, null: false
      t.string :model, null: false
      t.string :license_plate, null: false
      t.integer :year
      t.string :color, null: false
      t.float :milage
      t.references :fuel, foreign_key: true, null: false
      t.references :transmission, foreign_key: true, null: false
      t.integer :sell_price
      t.integer :buy_price
      t.integer :state, null: false, default: 1
      t.references :branch, foreign_key: true, null: false
      t.date :technical_review_expiration
      t.string :book
      t.string :publication
      t.string :cc
      t.string :permit
      t.string :soap
      t.string :appraisal
      t.string :property



      t.timestamps
    end
  end
end
