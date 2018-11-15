require 'rails_helper'

RSpec.describe "Acquisitions", type: :request do
  describe "GET /acquisitions" do
    it "works! (now write some real specs)" do
      get acquisitions_path
      expect(response).to have_http_status(200)
    end
  end
end
