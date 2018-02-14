class CreateClients < ActiveRecord::Migration[5.1]
  def change
    create_table :clients do |t|
      t.string :email, null: false
      t.string :name, null: false
      t.string :surname, null: false
      t.string :rut
      t.string :address
      t.integer :phone

      t.timestamps
    end
  end
end
