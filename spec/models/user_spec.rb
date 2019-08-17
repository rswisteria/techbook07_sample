require "rails_helper"

RSpec.describe User, type: :model do
  let(:name) { "Example User" }
  let(:email) { "user@example.com" }
  let(:password) { "foobar" }
  let(:password_confirmation) { "foobar" }

  subject { User.new(name: name, email: email, password: password, password_confirmation: password_confirmation) }

  describe "about validation" do
    context "with valid parameters" do
      it { is_expected.to be_valid }
    end

    context "with name which is only whitespaces" do
      let(:name) { "        " }
      it { is_expected.not_to be_valid }
    end

    context "with email which is only whitespaces" do
      let(:email) { "        " }
      it { is_expected.not_to be_valid }
    end

    context "with name which length is more than 50 characters" do
      let(:name) { "a" * 51 }
      it { is_expected.not_to be_valid }
    end

    context "with email which length is more than 255 characters" do
      let(:name) { "a" * 244 + "@example.com" }
      it { is_expected.not_to be_valid }
    end

    context "with invalid mail address" do
      context "with 'user@example,com'" do
        let(:email) { "user@example,com" }
        it { is_expected.not_to be_valid }
      end

      context "with user_at_foo.org" do
        let(:email) { "user_at_foo.org" }
        it { is_expected.not_to be_valid }
      end

      context "with user.name@example." do
        let(:email) { "user.name@example." }
        it { is_expected.not_to be_valid }
      end

      context "with foo@bar_baz.com" do
        let(:email) { "foo@bar_baz.com" }
        it { is_expected.not_to be_valid }
      end

      context "with foo@bar+baz.com" do
        let(:email) { "foo@bar+baz.com" }
        it { is_expected.not_to be_valid }
      end
    end

    context "with duplicated email address" do
      before do
        User.create(name: name, email: email.upcase, password: password, password_confirmation: password_confirmation)
      end
      it { is_expected.not_to be_valid }
    end

    context "with invalid password" do
      context "with password which has only whitespaces" do
        let(:password) { " " * 6 }
        let(:password_confirmation) { " " * 6 }
        it { is_expected.not_to be_valid }
      end

      context "with password which has only 5 characters" do
        let(:password) { "a" * 5 }
        let(:password_confirmation) { "a" * 5 }
        it { is_expected.not_to be_valid }
      end
    end
  end
end