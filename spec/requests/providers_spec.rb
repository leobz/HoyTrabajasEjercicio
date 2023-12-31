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
      contact_phone: nil, # optional field
      account_number: nil, # optional field
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

    it "fails with invalid params" do
      #*******   Provider NIC invalid   *******#
      invalid_params = valid_attributes.merge(nit: "invalid")

      expect {
        post providers_url, params: {provider: invalid_params}
      }.not_to change(Provider, :count) # Ensure that the Provider count doesn't change

      expect(response).to have_http_status(:unprocessable_entity)
      #expect(response.body).not_to include("Translation missing")
      expect(response.body).to include("invalid")

      #*******   Provider contact_name is nil   *******#
      invalid_params = valid_attributes.merge(contact_name: nil)
      expect {
        post providers_url, params: {provider: invalid_params}
      }.not_to change(Provider, :count) # Ensure that the Provider count doesn't change

      expect(response).to have_http_status(:unprocessable_entity)
      #expect(response.body).not_to include("Translation missing")
      expect(response.body).to include("invalid")

      #*******   Provider contact_phone greater than 10 chars   *******#
      invalid_params = valid_attributes.merge(contact_phone: '1' * 11)

      expect {
        post providers_url, params: {provider: invalid_params}
      }.not_to change(Provider, :count) # Ensure that the Provider count doesn't change

      expect(response).to have_http_status(:unprocessable_entity)
      #expect(response.body).not_to include("Translation missing")
      expect(response.body).to include("invalid")

      #*******   Provider account_number greater than 15 chars   *******#
      invalid_params = valid_attributes.merge(account_number: '1' * 16)

      expect {
        post providers_url, params: {provider: invalid_params}
      }.not_to change(Provider, :count) # Ensure that the Provider count doesn't change

      expect(response).to have_http_status(:unprocessable_entity)
      #expect(response.body).not_to include("Translation missing")
      expect(response.body).to include("invalid")

      #*******   Provider name is nil   *******#
      invalid_params = valid_attributes.merge(name: nil)

      expect {
        post providers_url, params: {provider: invalid_params}
      }.not_to change(Provider, :count) # Ensure that the Provider count doesn't change

      expect(response).to have_http_status(:unprocessable_entity)
      #expect(response.body).not_to include("Translation missing")
      expect(response.body).to include("invalid")


      #*******   Provider bank is nil   *******#
      invalid_params = valid_attributes.merge(bank_id: nil)

      expect {
        post providers_url, params: {provider: invalid_params}
      }.not_to change(Provider, :count) # Ensure that the Provider count doesn't change

      expect(response).to have_http_status(:unprocessable_entity)
      #expect(response.body).not_to include("Translation missing")
      expect(response.body).to include("invalid")
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