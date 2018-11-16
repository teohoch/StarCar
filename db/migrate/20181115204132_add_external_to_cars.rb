class AddExternalToCars < ActiveRecord::Migration[5.1]
  def up
    add_column :cars, :external, :bool, :default => false
    Car.update_all(external: false)
  end

  def down
    remove_column :cars, :external
  end
end
