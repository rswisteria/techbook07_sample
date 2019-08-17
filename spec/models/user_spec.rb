require "rails_helper"

RSpec.describe User, type: :model do
  let(:name) { "Example User" }
  let(:email) { "user@example.com" }

  subject { User.new(name: name, email: email) }

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
        let(:email) { "user@example,com"}
        it { is_expected.not_to be_valid }
      end
    end
  end
end