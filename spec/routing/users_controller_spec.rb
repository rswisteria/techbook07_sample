require "rails_helper"

RSpec.describe "routes for StaticPage", type: :routing do
  it { expect(get("/signup")).to route_to("users#new") }
end