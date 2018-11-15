require 'rails_helper'

RSpec.describe "acquisitions/show", type: :view do
  before(:each) do
    @acquisition = assign(:acquisition, Acquisition.create!(
      :employee => nil,
      :amount_paid => "",
      :car_provider => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
