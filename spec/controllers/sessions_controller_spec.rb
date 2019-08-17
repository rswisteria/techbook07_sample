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
    let(:remember_me) { '0' }
    before do
      post :create, params: {
          session: {
              email: user.email,
              password: 'password',
              remember_me: remember_me
          }
      }
    end

    context "without remember_me" do
      describe "about response" do
        subject { response }
        it { is_expected.to redirect_to(user) }
      end

      describe "about cookie" do
        subject { response.cookies['remember_token'] }
        it { is_expected.to be_nil }
      end
    end

    context "with remember_me" do
      let(:remember_me) { '1' }
      describe "about cookie" do
        subject { response.cookies['remember_token'] }
        it { is_expected.not_to be_nil }
      end
    end
  end

  describe "DELETE #destroy" do
    let(:user) { create(:user) }
    let(:remember_me) { '1' }
    before do
      post :create, params: {
          session: {
              email: user.email,
              password: 'password',
              remember_me: remember_me
          }
      }
      delete :destroy
    end

    describe "about response" do
      subject { response }
      it { is_expected.to redirect_to(root_path) }
    end

    describe "about cookie" do
      subject { response.cookies['remember_token'] }
      it { is_expected.to be_nil }
    end
  end
end
