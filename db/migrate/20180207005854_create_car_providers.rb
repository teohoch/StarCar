class CreateCarProviders < ActiveRecord::Migration[5.1]
  def change
    create_table :car_providers do |t|
      t.string :name

      t.timestamps
    end
  end
end
