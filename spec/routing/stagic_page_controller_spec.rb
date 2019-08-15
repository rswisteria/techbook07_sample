require "rails_helper"

RSpec.describe "routes for StaticPage", type: :routing do
  it { expect(get("/")).to route_to("static_pages#home") }
  it { expect(get("/help")).to route_to("static_pages#help") }
  it { expect(get("/about")).to route_to("static_pages#about") }
  it { expect(get("/contact")).to route_to("static_pages#contact") }
end