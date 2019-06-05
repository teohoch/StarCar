class AddDeletedAtToBrands < ActiveRecord::Migration[5.1]
  def change
    add_column :brands, :deleted_at, :datetime
    add_index :brands, :deleted_at
  end
end
