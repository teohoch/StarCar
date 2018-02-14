require 'rails_helper'

RSpec.describe "clients/show", type: :view do
  before(:each) do
    @client = assign(:client, Client.create!(
      :email => "Email",
      :name => "Name",
      :surname => "Surname",
      :rut => "Rut",
      :address => "Address",
      :phone => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Surname/)
    expect(rendered).to match(/Rut/)
    expect(rendered).to match(/Address/)
    expect(rendered).to match(/2/)
  end
end
