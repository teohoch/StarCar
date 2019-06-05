class CreateVehiclePayments < ActiveRecord::Migration[5.1]
  def change
    create_table :vehicle_payments do |t|
      t.bigint :amount, :null => false, :default => 0
      t.integer :vehicle_payable_id
      t.string :vehicle_payable_type
      t.integer :status
      t.references :car, foreign_key: true
      t.boolean :mock

      t.timestamps
    end
  end
end
