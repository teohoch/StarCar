class AddStatusToCashPayment < ActiveRecord::Migration[5.1]
  def change
    add_column :cash_payments, :status, :integer
  end
end
