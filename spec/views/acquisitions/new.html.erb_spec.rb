require 'rails_helper'

RSpec.describe "acquisitions/new", type: :view do
  before(:each) do
    assign(:acquisition, Acquisition.new(
      :employee => nil,
      :amount_paid => "",
      :car_provider => nil
    ))
  end

  it "renders new acquisition form" do
    render

    assert_select "form[action=?][method=?]", acquisitions_path, "post" do

      assert_select "input[name=?]", "acquisition[employee_id]"

      assert_select "input[name=?]", "acquisition[amount_paid]"

      assert_select "input[name=?]", "acquisition[car_provider_id]"
    end
  end
end
