class CreateCardPayments < ActiveRecord::Migration[5.1]
  def change
    create_table :card_payments do |t|
      t.bigint :amount
      t.references :sale, foreign_key: true
      t.bigint :card_number
      t.integer :card_type
      t.integer :status
      t.string :bank

      t.timestamps
    end
  end
end
