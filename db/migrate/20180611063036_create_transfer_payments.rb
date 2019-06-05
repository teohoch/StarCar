class CreateTransferPayments < ActiveRecord::Migration[5.1]
  def change
    create_table :transfer_payments do |t|
      t.bigint :amount, :null => false, :default => 0
      t.bigint :deposit, :null => false, :default => 0
      t.integer :transfer_payable_id
      t.string :transfer_payable_type
      t.integer :status

      t.timestamps
    end
  end
end
