class PopulateBrands < ActiveRecord::Migration[5.1]
  BRANDS = %w[Alfa Romeo Aston Martin Audi Bentley Benz BMW Bugatti Cadillac Chevrolet Chrysler Citroen Corvette DAF Dacia Daewoo Daihatsu Datsun De Lorean Dino Dodge Farboud Ferrari Fiat Ford Honda Hummer Hyundai Jaguar Jeep KIA Koenigsegg Lada Lamborghini Lancia Land Rover Lexus Ligier Lincoln Lotus Martini Maserati Maybach Mazda McLaren Mercedes Mercedes-Benz Mini Mitsubishi Nissan Noble Opel Peugeot Pontiac Porsche Renault Rolls-Royce Rover Saab Seat Skoda Smart Spyker Subaru Suzuki Toyota Vauxhall Volkswagen Volvo].freeze
  def up
    BRANDS.each do |brands_name|
      Brand.create! name: brands_name
    end
  end

  def down
    BRANDS.where(name: BRANDS).destroy_all
  end

end
