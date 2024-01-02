require "rails_helper"
require "support_helper"

RSpec.describe "Charts Requests", type: :request do
  before(:each) do
    sign_in_test_user()
  end

  describe "GET #providers_per_bank" do
    it "it's successful" do
      b1 = Bank.create! name: "b1"
      b2 = Bank.create! name: "b2"

      # Bank 1 with 1 provider
      create_test_provider(b1)

      # Bank 2 with 3 providers
      create_test_provider(b2)
      create_test_provider(b2)
      create_test_provider(b2)

      get providers_per_bank_path

      # Asserts
      expect(response).to be_successful
      parsed_body = JSON.parse(response.body)
      expect(parsed_body["b1"]).to eq(1)
      expect(parsed_body["b2"]).to eq(3)
    end
  end

  describe "GET #providers_resgistration_per_month" do
    it "it's successful" do
      p1 = create_test_provider()
      p2 = create_test_provider()
      p3 = create_test_provider()

      # Set 1 providers in month 01/2000
      p = create_test_provider()
      p.created_at = Time.new(2000, 01, 10)
      p.save

      # Set 2 providers in month 05/2000
      p = create_test_provider()
      p.created_at = Time.new(2000, 05, 10)
      p.save
    
      p = create_test_provider()
      p.created_at = Time.new(2000, 05, 20)
      p.save

      get providers_resgistration_per_month_path

      # Asserts
      expect(response).to be_successful
      parsed_body = JSON.parse(response.body)
      expect(parsed_body["2000-01-01"]).to eq(1)
      expect(parsed_body["2000-05-01"]).to eq(2)
    end
  end
end