class CreateSales < ActiveRecord::Migration[5.1]
  def change
    create_table :sales do |t|
      t.references :employee, foreign_key: true
      t.references :car, foreign_key: true
      t.references :client, foreign_key: true
      t.integer :price

      t.timestamps
    end
  end
end
