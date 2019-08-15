require "rails_helper"

RSpec.describe "routes for StaticPage", type: :routing do
  it { expect(get("/static_pages/home")).to route_to("static_pages#home") }
  it { expect(get("/static_pages/help")).to route_to("static_pages#help") }
  it { expect(get("/static_pages/about")).to route_to("static_pages#about") }
  it { expect(get("/static_pages/contact")).to route_to("static_pages#contact") }
end