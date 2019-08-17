require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "#create" do
    let(:name) { "Yuzu Kitami" }
    let(:email) { "yuzu@example.com" }
    let(:password) { "hogehoge" }
    let(:password_confirmation) { "hogehoge" }

    before do
      post :create, params: {
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
      let(:email) { "" }

      it { is_expected.to render_template(:new) }
    end
  end
end