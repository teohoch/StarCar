require "rails_helper"

RSpec.describe AcquisitionsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/acquisitions").to route_to("acquisitions#index")
    end

    it "routes to #new" do
      expect(:get => "/acquisitions/new").to route_to("acquisitions#new")
    end

    it "routes to #show" do
      expect(:get => "/acquisitions/1").to route_to("acquisitions#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/acquisitions/1/edit").to route_to("acquisitions#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/acquisitions").to route_to("acquisitions#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/acquisitions/1").to route_to("acquisitions#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/acquisitions/1").to route_to("acquisitions#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/acquisitions/1").to route_to("acquisitions#destroy", :id => "1")
    end
  end
end
