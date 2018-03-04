require 'rails_helper'

RSpec.describe "sales/new", type: :view do
  before(:each) do
    assign(:sale, Sale.new(
      :employee => nil,
      :car => nil,
      :client => nil,
      :price => 1
    ))
  end

  it "renders new sale form" do
    render

    assert_select "form[action=?][method=?]", sales_path, "post" do

      assert_select "input[name=?]", "sale[employee_id]"

      assert_select "input[name=?]", "sale[car_id]"

      assert_select "input[name=?]", "sale[client_id]"

      assert_select "input[name=?]", "sale[price]"
    end
  end
end
