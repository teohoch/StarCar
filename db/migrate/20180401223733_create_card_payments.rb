class CreateCardPayments < ActiveRecord::Migration[5.1]
  def change
    create_table :card_payments do |t|
      t.bigint :amount, :null => false, :default => 0
      t.integer :card_payable_id
      t.string :card_payable_type
      t.bigint :card_number
      t.integer :card_type
      t.integer :status
      t.string :bank

      t.timestamps
    end
  end
end
