class CreateFinancierPayments < ActiveRecord::Migration[5.1]
  def change
    create_table :financier_payments do |t|
      t.bigint :amount
      t.references :sale, foreign_key: true
      t.integer :status
      t.references :financier, foreign_key: true
      t.bigint :discount
      t.bigint :down_payment

      t.timestamps
    end
  end
end
