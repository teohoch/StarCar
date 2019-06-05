class PopulateFuels < ActiveRecord::Migration[5.1]
  FUELS = %w[gas petrol electric hybrid liquid_gas ].freeze
  def up
    FUELS.each do |fuels_name|
      Fuel.create! name: fuels_name
    end
  end

  def down
    Fuel.where(name: FUELS).destroy_all
  end
end
