class CreateCheckPayments < ActiveRecord::Migration[5.1]
  def change
    create_table :check_payments do |t|
      t.bigint :amount
      t.references :sale, foreign_key: true
      t.integer :status
      t.bigint :code
      t.integer :number
      t.date :date
      t.string :bank

      t.timestamps
    end
  end
end
