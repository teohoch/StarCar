class CreateCars < ActiveRecord::Migration[5.1]
  def change
    create_table :cars do |t|
      t.references :brand, foreign_key: true, null: false
      t.string :model, null: false
      t.string :license_plate, null: false, index: { unique: true }
      t.integer :year
      t.string :color, null: false
      t.float :milage
      t.references :fuel, foreign_key: true
      t.references :transmission, foreign_key: true
      t.bigint :list_price
      t.bigint :buy_price
      t.integer :state, null: false, default: 0
      t.references :branch, foreign_key: true, null: false
      t.date :technical_review_expiration
      t.string :book
      t.string :cc
      t.date :permit
      t.integer :soap
      t.string :property



      t.timestamps
    end
  end
end
