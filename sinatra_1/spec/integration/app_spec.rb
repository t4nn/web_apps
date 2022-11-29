require "spec_helper"
require "rack/test"
require_relative "../../app"

describe Application do
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  context "GET /names" do
    it "should return Julia, Mary, Karim" do
      response = get("/names")

      expect(response.status).to eq(200)
      expect(response.body).to eq("Julia, Mary, Karim")
    end
  end
end

#   context "POST /submit" do
#     it "returns 200 ok" do
#         response = post("/submit", name: "Tanya", cohort_name: "October")
#         expect(response.status).to eq(200)
#         expect(response.body).to eq("Hello Tanya")
#     end
