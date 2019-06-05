class AddDeletedAtToCars < ActiveRecord::Migration[5.1]
  def change
    add_column :cars, :deleted_at, :datetime
    add_index :cars, :deleted_at
  end
end
