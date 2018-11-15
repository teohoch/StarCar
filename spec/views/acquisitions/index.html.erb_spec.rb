require 'rails_helper'

RSpec.describe "acquisitions/index", type: :view do
  before(:each) do
    assign(:acquisitions, [
      Acquisition.create!(
        :employee => nil,
        :amount_paid => "",
        :car_provider => nil
      ),
      Acquisition.create!(
        :employee => nil,
        :amount_paid => "",
        :car_provider => nil
      )
    ])
  end

  it "renders a list of acquisitions" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
