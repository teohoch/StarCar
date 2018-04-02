class CreateCashPayments < ActiveRecord::Migration[5.1]
  def change
    create_table :cash_payments do |t|
      t.bigint :amount
      t.references :sale, foreign_key: true
      t.integer :deposit_number

      t.timestamps
    end
  end
end
