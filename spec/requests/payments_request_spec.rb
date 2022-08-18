require 'rails_helper'

RSpec.describe "Payments", type: :request do

  describe "GET /show" do
    it "returns http success" do
      get "/payments/show"
      expect(response).to have_http_status(:success)
    end
  end

end
