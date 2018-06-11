class CreateSales < ActiveRecord::Migration[5.1]
  def change
    create_table :sales do |t|
      t.references :branch, foreign_key: true
      t.references :employee, foreign_key: true
      t.references :car, foreign_key: true
      t.references :client, foreign_key: true
      t.bigint :final_price
      t.bigint :appraisal
      t.bigint :tax
      t.bigint :transfer_cost
      t.bigint :transfer_discount
      t.bigint :list_discount
      t.bigint :earnings
      t.bigint :pva
      t.bigint :list_price
      t.bigint :buy_price
      t.text   :comment
      t.integer :status, default: 0



      t.timestamps
    end
  end
end
