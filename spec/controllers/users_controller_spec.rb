require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "#index" do
    let(:login_user) { user }
    let(:user) { create(:user) }

    before do
      session[:user_id] = login_user&.id
      get :index
    end

    subject { response }

    context "without logged in" do
      let(:login_user) { nil }
      it { is_expected.to redirect_to(login_url) }
    end
  end

  describe "#create" do
    let(:name) { "Yuzu Kitami" }
    let(:email) { "yuzu@example.com" }
    let(:password) { "hogehoge" }
    let(:password_confirmation) { "hogehoge" }

    before do
      ActionMailer::Base.deliveries.clear
      post :create, params: {
          user: {
              name: name,
              email: email,
              password: password,
              password_confirmation: password_confirmation
          }
      }
    end

    context "with valid params" do
      describe "about response" do
        subject { response }
        it { is_expected.to redirect_to(root_path) }
      end

      describe "about activation mail" do

      end
    end

    context "with invalid params" do
      let(:email) { "" }

      it { is_expected.to render_template(:new) }
    end
  end

  describe "#update" do
    let(:login_user) { user }
    let(:user) { create(:user) }
    let(:name) { "Yuzu Kitami" }
    let(:email) { "yuzu@example.com" }
    let(:password) { "hogehoge" }
    let(:password_confirmation) { "hogehoge" }

    before do
      session[:user_id] = login_user&.id
      patch :update, params: {
          id: user.id,
          user: {
              name: name,
              email: email,
              password: password,
              password_confirmation: password_confirmation
          }
      }
    end

    subject { response }

    context "with valid params" do
      it { is_expected.to redirect_to(user_path(id: User.last.id)) }
    end

    context "with invalid params" do
      let(:password_confirmation) { "fugafuga" }

      it { is_expected.to render_template(:edit) }
    end

    context "without logged in" do
      let(:login_user) { nil }
      it { is_expected.to redirect_to(login_path) }
    end

    context "with another user" do
      let(:login_user) { create(:user, name: 'Asuka Ninomiya', email: 'asuka@example.com') }
      it { is_expected.to redirect_to(root_url) }
    end
  end

  describe "#update" do
    let(:login_user) { create(:user, email: 'admin@example.com', admin: admin) }
    let(:user) { create(:user) }
    let(:admin) { true }

    before do
      session[:user_id] = login_user&.id
      delete :destroy, params: { id: user.id }
    end

    context "with admin user" do
      describe "about response" do
        subject { response }
        it { is_expected.to redirect_to(users_url) }
      end

      describe "about records" do
        subject { User.find_by(id: user.id) }
        it { is_expected.to be_nil }
      end
    end

    context "without admin user" do
      let(:admin) { false }
      describe "about response" do
        subject { response }
        it { is_expected.to redirect_to(root_url) }
      end
    end
  end
end