class CreateCashPayments < ActiveRecord::Migration[5.1]
  def change
    create_table :cash_payments do |t|
      t.bigint :amount
      t.integer :cash_payable_id
      t.string :cash_payable_type

      t.timestamps
    end
  end
end
