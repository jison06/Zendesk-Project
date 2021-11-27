require 'rails_helper'

RSpec.describe TicketsController, type: :controller do
  before do

  end

  describe "GET /index" do
    it 'has a 200 status code' do
      get :index
      expect(response.status).to eq(200)
    end

    describe 'responds_to' do
      it "responds to html by default" do
        get :index
        expect(response.content_type).to include "text/html"
      end

      it 'responds to json when provided' do
        get :index, format: :json
        expect(response.content_type).to include "application/json"
      end
    end
  end
end
