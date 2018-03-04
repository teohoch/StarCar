require 'rails_helper'

RSpec.describe "sales/index", type: :view do
  before(:each) do
    assign(:sales, [
      Sale.create!(
        :employee => nil,
        :car => nil,
        :client => nil,
        :price => 2
      ),
      Sale.create!(
        :employee => nil,
        :car => nil,
        :client => nil,
        :price => 2
      )
    ])
  end

  it "renders a list of sales" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
