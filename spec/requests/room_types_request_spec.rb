require 'rails_helper'

RSpec.describe "RoomTypes", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/room_types/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/room_types/show"
      expect(response).to have_http_status(:success)
    end
  end

end
