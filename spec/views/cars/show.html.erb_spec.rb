require 'rails_helper'

RSpec.describe "cars/show", type: :view do
  before(:each) do
    @car = assign(:car, Car.create!(
      :brand => nil,
      :model => "Model",
      :license_plate => "License Plate",
      :year => 2,
      :color => "Color",
      :milage => 3.5,
      :maintenances => 4,
      :Fuel => nil,
      :Transmission => nil,
      :prepaid => "Prepaid"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Model/)
    expect(rendered).to match(/License Plate/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Color/)
    expect(rendered).to match(/3.5/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/Prepaid/)
  end
end
