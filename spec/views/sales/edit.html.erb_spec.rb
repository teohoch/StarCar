require 'rails_helper'

RSpec.describe "sales/edit", type: :view do
  before(:each) do
    @sale = assign(:sale, Sale.create!(
      :employee => nil,
      :car => nil,
      :client => nil,
      :price => 1
    ))
  end

  it "renders the edit sale form" do
    render

    assert_select "form[action=?][method=?]", sale_path(@sale), "post" do

      assert_select "input[name=?]", "sale[employee_id]"

      assert_select "input[name=?]", "sale[car_id]"

      assert_select "input[name=?]", "sale[client_id]"

      assert_select "input[name=?]", "sale[price]"
    end
  end
end
