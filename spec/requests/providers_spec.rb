require "rails_helper"

RSpec.describe "Provider Requests", type: :request do
  before(:each) do
    @bank = Bank.create! name: "My bank"
  end

  let(:valid_attributes) {
    {
      nit: "901362343-4",
      name: "Provider",
      contact_name: "Jhon",
      contact_phone: "+111111",
      account_number: "111111",
      bank_id: @bank.id
    }
  }

  describe "GET #index" do
    it "returns a list of providers" do
      Provider.create! valid_attributes.merge(nit: "111111111-1")
      Provider.create! valid_attributes.merge(nit: "222222222-2")

      get providers_url

      expect(response).to be_successful
      provider1, provider2 =  assigns(:providers)
      expect(provider1.nit).to eq("111111111-1")
      expect(provider2.nit).to eq("222222222-2")

      # Translation asserts
      expect(response.body).not_to include("Translation missing")
    end
  end

  describe "GET #show" do
    it "returns a provider" do
      Provider.create! valid_attributes
      get provider_url(Provider.last)

      expect(response).to be_successful
      expect(Provider.last).to eq(assigns(:provider))
      expect(Provider.last.nit).to eq(valid_attributes[:nit])

      # Translation asserts
      expect(response.body).not_to include("Translation missing")
    end
  end

  describe "POST #create" do
    it "creates a new Provider" do
      expect {
        post providers_url, params: {provider: valid_attributes}
      }.to change(Provider, :count).by(1)

      expect(response).to redirect_to(assigns(:provider))
      expect(Provider.last).to eq(assigns(:provider))
      expect(Provider.last.nit).to eq(valid_attributes[:nit])

      # Translation asserts
      follow_redirect!
      expect(response.body).not_to include("Translation missing")
    end
  end

  describe "PUT #update" do
    it "updates a Provider" do
      provider = Provider.create! valid_attributes.merge(nit: "000000000-0")
      expect(Provider.last.nit).to eq("000000000-0")

      put provider_url(provider), params: {provider: valid_attributes}

      expect(Provider.last).to eq(assigns(:provider))
      expect(Provider.last.nit).to eq(valid_attributes[:nit])

      # Translation asserts
      follow_redirect!
      expect(response.body).not_to include("Translation missing")
    end
  end

  describe "DELETE #destroy" do
    it "destroys a Provider" do
      provider = Provider.create! valid_attributes
      expect { delete provider_url(provider) }.to change(Provider, :count).by(-1)

      # Translation asserts
      follow_redirect!
      expect(response.body).not_to include("Translation missing")
    end
  end
end

# Helper functions
def expect_translation_success()
  expect(response.body).not_to include("Translation missing")
end