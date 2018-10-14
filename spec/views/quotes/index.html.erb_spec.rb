require 'rails_helper'

RSpec.describe "quotes/index", type: :view do
  before(:each) do
    assign(:quotes, [
      Quote.create!(
        :car => nil,
        :client => nil,
        :employee => nil,
        :branch => nil,
        :quote_price => ""
      ),
      Quote.create!(
        :car => nil,
        :client => nil,
        :employee => nil,
        :branch => nil,
        :quote_price => ""
      )
    ])
  end

  it "renders a list of quotes" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
