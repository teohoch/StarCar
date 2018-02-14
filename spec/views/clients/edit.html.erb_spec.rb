require 'rails_helper'

RSpec.describe "clients/edit", type: :view do
  before(:each) do
    @client = assign(:client, Client.create!(
      :email => "MyString",
      :name => "MyString",
      :surname => "MyString",
      :rut => "MyString",
      :address => "MyString",
      :phone => 1
    ))
  end

  it "renders the edit client form" do
    render

    assert_select "form[action=?][method=?]", client_path(@client), "post" do

      assert_select "input[name=?]", "client[email]"

      assert_select "input[name=?]", "client[name]"

      assert_select "input[name=?]", "client[surname]"

      assert_select "input[name=?]", "client[rut]"

      assert_select "input[name=?]", "client[address]"

      assert_select "input[name=?]", "client[phone]"
    end
  end
end
