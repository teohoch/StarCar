class CreateCosts < ActiveRecord::Migration[5.1]
  def change
    create_table :costs do |t|
      t.references :car, foreign_key: true
      t.text :reason
      t.integer :amount

      t.timestamps
    end
  end
end
