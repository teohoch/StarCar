require 'rails_helper'

RSpec.describe "clients/index", type: :view do
  before(:each) do
    assign(:clients, [
      Client.create!(
        :email => "Email",
        :name => "Name",
        :surname => "Surname",
        :rut => "Rut",
        :address => "Address",
        :phone => 2
      ),
      Client.create!(
        :email => "Email",
        :name => "Name",
        :surname => "Surname",
        :rut => "Rut",
        :address => "Address",
        :phone => 2
      )
    ])
  end

  it "renders a list of clients" do
    render
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Surname".to_s, :count => 2
    assert_select "tr>td", :text => "Rut".to_s, :count => 2
    assert_select "tr>td", :text => "Address".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
