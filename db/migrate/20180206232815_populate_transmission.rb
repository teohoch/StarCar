class PopulateTransmission < ActiveRecord::Migration[5.1]
  TRANSMISSIONS = ['manual', 'automatic']
  def up
    TRANSMISSIONS.each do |transmission_name|
      Transmission.create! name: transmission_name
    end
  end
  def down
    Transmission.where(name: TRANSMISSIONS).destroy_all
  end
end
