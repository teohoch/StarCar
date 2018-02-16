class CreateBranches < ActiveRecord::Migration[5.1]
  def change
    create_table :branches do |t|
      t.string :title
      t.string :location
      t.integer :phone
      t.references :manager, index: true, null: false, foreign_key: {to_table: :employees}

      t.timestamps
    end
  end
end
