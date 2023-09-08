require 'rails_helper'

RSpec.describe "Api::V1::LearningPaths", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/api/v1/learning_path/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/api/v1/learning_path/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/api/v1/learning_path/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/api/v1/learning_path/update"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/api/v1/learning_path/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
