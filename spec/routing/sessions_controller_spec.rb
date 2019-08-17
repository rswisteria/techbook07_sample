require "rails_helper"

RSpec.describe "routes for Sessions", type: :routing do
  it { expect(get("/login")).to route_to("sessions#new") }
  it { expect(post("/login")).to route_to("sessions#create") }
  it { expect(delete("/logout")).to route_to("sessions#destroy") }
end