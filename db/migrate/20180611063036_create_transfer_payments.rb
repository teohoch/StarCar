class CreateTransferPayments < ActiveRecord::Migration[5.1]
  def change
    create_table :transfer_payments do |t|
      t.bigint :amount
      t.bigint :deposit
      t.references :sale, foreign_key: true
      t.integer :status

      t.timestamps
    end
  end
end
