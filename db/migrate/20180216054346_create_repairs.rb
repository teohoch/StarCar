class CreateRepairs < ActiveRecord::Migration[5.1]
  def change
    create_table :repairs do |t|
      t.string :workshop
      t.references :employee, foreign_key: true
      t.references :car, foreign_key: true
      t.text :reason
      t.integer :quote
      t.integer :status
      t.date :return_date

      t.timestamps
    end
  end
end
