class CreateCheckPayments < ActiveRecord::Migration[5.1]
  def change
    create_table :check_payments do |t|
      t.bigint :amount
      t.integer :check_payable_id
      t.string :check_payable_type
      t.integer :status
      t.bigint :code
      t.integer :number
      t.date :date
      t.string :bank

      t.timestamps
    end
  end
end
