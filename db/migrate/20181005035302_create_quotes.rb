class CreateQuotes < ActiveRecord::Migration[5.1]
  def change
    create_table :quotes do |t|
      t.references :car, foreign_key: true
      t.references :client, foreign_key: true
      t.references :employee, foreign_key: true
      t.references :branch, foreign_key: true
      t.bigint :quote_price

      t.timestamps
    end
  end
end
