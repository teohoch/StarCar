class CreateVehiclePayments < ActiveRecord::Migration[5.1]
  def change
    create_table :vehicle_payments do |t|
      t.bigint :amount
      t.references :sale, foreign_key: true
      t.integer :status
      t.references :car, foreign_key: true
      t.boolean :mock

      t.timestamps
    end
  end
end
