require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    let(:user) { create(:user) }
    before do
      post :create, params: {
          session: {
              email: user.email,
              password: 'password'
          }
      }
    end

    subject { response }

    it { is_expected.to redirect_to(user) }
  end
end
