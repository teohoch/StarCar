class CreateFuels < ActiveRecord::Migration[5.1]
  def change
    create_table :fuels do |t|
      t.string :name
    end
  end
end
