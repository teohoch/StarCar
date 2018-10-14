require 'rails_helper'

RSpec.describe "quotes/new", type: :view do
  before(:each) do
    assign(:quote, Quote.new(
      :car => nil,
      :client => nil,
      :employee => nil,
      :branch => nil,
      :quote_price => ""
    ))
  end

  it "renders new quote form" do
    render

    assert_select "form[action=?][method=?]", quotes_path, "post" do

      assert_select "input[name=?]", "quote[car_id]"

      assert_select "input[name=?]", "quote[client_id]"

      assert_select "input[name=?]", "quote[employee_id]"

      assert_select "input[name=?]", "quote[branch_id]"

      assert_select "input[name=?]", "quote[quote_price]"
    end
  end
end
