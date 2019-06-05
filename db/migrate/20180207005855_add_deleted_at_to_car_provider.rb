class AddDeletedAtToCarProvider < ActiveRecord::Migration[5.1]
  def change
    add_column :car_providers, :deleted_at, :datetime
    add_index :car_providers, :deleted_at
  end
end
