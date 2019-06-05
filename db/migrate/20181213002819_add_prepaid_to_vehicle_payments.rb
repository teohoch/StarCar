class AddPrepaidToVehiclePayments < ActiveRecord::Migration[5.1]
  def change
    add_reference :vehicle_payments, :financier, foreign_key: true
    add_column :vehicle_payments, :prepaid, :bigint
  end
end
