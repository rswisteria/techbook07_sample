require "rails_helper"

RSpec.describe Micropost, type: :model do
  let(:user) { create(:user) }
  let(:content) { "Hello, World!" }

  before do
    @micropost = Micropost.new(user: user, content: content)
  end

  subject { @micropost }

  context "with valid params" do
    it { is_expected.to be_valid }
  end

  context "without user" do
    let(:user) { nil }
    it { is_expected.not_to be_valid }
  end

  context "with content which has only whitespace" do
    let(:content) { "     " }
    it { is_expected.not_to be_valid }
  end

  context "with content which length is more than 140" do
    let(:content) { "a" * 141 }
    it { is_expected.not_to be_valid }
  end
end