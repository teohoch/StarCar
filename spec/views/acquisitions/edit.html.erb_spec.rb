require 'rails_helper'

RSpec.describe "acquisitions/edit", type: :view do
  before(:each) do
    @acquisition = assign(:acquisition, Acquisition.create!(
      :employee => nil,
      :amount_paid => "",
      :car_provider => nil
    ))
  end

  it "renders the edit acquisition form" do
    render

    assert_select "form[action=?][method=?]", acquisition_path(@acquisition), "post" do

      assert_select "input[name=?]", "acquisition[employee_id]"

      assert_select "input[name=?]", "acquisition[amount_paid]"

      assert_select "input[name=?]", "acquisition[car_provider_id]"
    end
  end
end
