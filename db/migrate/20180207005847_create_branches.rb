class CreateBranches < ActiveRecord::Migration[5.1]
  def change
    create_table :branches do |t|
      t.string :title
      t.string :location
      t.integer :phone

      t.timestamps
    end
  end
end
