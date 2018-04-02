class CreateFinanciers < ActiveRecord::Migration[5.1]
  def change
    create_table :financiers do |t|
      t.string :name

      t.timestamps
    end
  end
end
