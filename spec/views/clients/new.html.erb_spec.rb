require 'rails_helper'

RSpec.describe "clients/new", type: :view do
  before(:each) do
    assign(:client, Client.new(
      :email => "MyString",
      :name => "MyString",
      :surname => "MyString",
      :rut => "MyString",
      :address => "MyString",
      :phone => 1
    ))
  end

  it "renders new client form" do
    render

    assert_select "form[action=?][method=?]", clients_path, "post" do

      assert_select "input[name=?]", "client[email]"

      assert_select "input[name=?]", "client[name]"

      assert_select "input[name=?]", "client[surname]"

      assert_select "input[name=?]", "client[rut]"

      assert_select "input[name=?]", "client[address]"

      assert_select "input[name=?]", "client[phone]"
    end
  end
end
