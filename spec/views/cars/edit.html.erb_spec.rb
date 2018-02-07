require 'rails_helper'

RSpec.describe "cars/edit", type: :view do
  before(:each) do
    @car = assign(:car, Car.create!(
      :brand => nil,
      :model => "MyString",
      :license_plate => "MyString",
      :year => 1,
      :color => "MyString",
      :milage => 1.5,
      :maintenances => 1,
      :Fuel => nil,
      :Transmission => nil,
      :prepaid => "MyString"
    ))
  end

  it "renders the edit car form" do
    render

    assert_select "form[action=?][method=?]", car_path(@car), "post" do

      assert_select "input[name=?]", "car[brand_id]"

      assert_select "input[name=?]", "car[model]"

      assert_select "input[name=?]", "car[license_plate]"

      assert_select "input[name=?]", "car[year]"

      assert_select "input[name=?]", "car[color]"

      assert_select "input[name=?]", "car[milage]"

      assert_select "input[name=?]", "car[maintenances]"

      assert_select "input[name=?]", "car[FuelType_id]"

      assert_select "input[name=?]", "car[Transmission_id]"

      assert_select "input[name=?]", "car[prepaid]"
    end
  end
end
