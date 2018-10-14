require 'rails_helper'

RSpec.describe "quotes/edit", type: :view do
  before(:each) do
    @quote = assign(:quote, Quote.create!(
      :car => nil,
      :client => nil,
      :employee => nil,
      :branch => nil,
      :quote_price => ""
    ))
  end

  it "renders the edit quote form" do
    render

    assert_select "form[action=?][method=?]", quote_path(@quote), "post" do

      assert_select "input[name=?]", "quote[car_id]"

      assert_select "input[name=?]", "quote[client_id]"

      assert_select "input[name=?]", "quote[employee_id]"

      assert_select "input[name=?]", "quote[branch_id]"

      assert_select "input[name=?]", "quote[quote_price]"
    end
  end
end
