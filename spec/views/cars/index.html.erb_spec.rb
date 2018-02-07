require 'rails_helper'

RSpec.describe "cars/index", type: :view do
  before(:each) do
    assign(:cars, [
      Car.create!(
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
      ),
      Car.create!(
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
      )
    ])
  end

  it "renders a list of cars" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Model".to_s, :count => 2
    assert_select "tr>td", :text => "License Plate".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Color".to_s, :count => 2
    assert_select "tr>td", :text => 3.5.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Prepaid".to_s, :count => 2
  end
end
