class AddDeletedAtToFinanciers < ActiveRecord::Migration[5.1]
  def change
    add_column :financiers, :deleted_at, :datetime
    add_index :financiers, :deleted_at
  end
end
