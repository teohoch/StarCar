class CreateFinancierPayments < ActiveRecord::Migration[5.1]
  def change
    create_table :financier_payments do |t|
      t.bigint :amount
      t.integer :financier_payable_id
      t.string :financier_payable_type
      t.integer :status
      t.references :financier, foreign_key: true
      t.bigint :down_payment

      t.timestamps
    end
  end
end
