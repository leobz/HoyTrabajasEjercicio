require "rails_helper"

RSpec.describe "Bank Requests", type: :request do
  let(:valid_attributes) {{name: "My bank"}}

  describe "GET #index" do
    it "returns a list of banks" do
      Bank.create! name: "Bank 1"
      Bank.create! name: "Bank 2"

      get banks_url

      expect(response).to be_successful
      bank1, bank2 =  assigns(:banks)
      expect(bank1.name).to eq("Bank 1")
      expect(bank2.name).to eq("Bank 2")

      # Translation asserts
      expect(response.body).not_to include("Translation missing")
    end
  end

  describe "GET #show" do
    it "returns a bank" do
      Bank.create! valid_attributes
      get bank_url(Bank.last)

      expect(response).to be_successful
      expect(Bank.last).to eq(assigns(:bank))
      expect(Bank.last.name).to eq("My bank")

      # Translation asserts
      expect(response.body).not_to include("Translation missing")
    end
  end

  describe "POST #create" do
    it "creates a new Bank" do
      expect {
        post banks_url, params: {bank: valid_attributes}
      }.to change(Bank, :count).by(1)

      expect(response).to redirect_to(assigns(:bank))
      expect(Bank.last).to eq(assigns(:bank))
      expect(Bank.last.name).to eq("My bank")

      # Translation asserts
      follow_redirect!
      expect(response.body).not_to include("Translation missing")
    end

    it "fails with invalid params" do
      #*******   Bank name greater than 50 chars   *******#
      invalid_long_name = 'a' * 51

      expect {
        post banks_url, params: {bank: {name: invalid_long_name}}
      }.not_to change(Bank, :count) # Ensure that the Bank count doesn't change

      expect(response).to have_http_status(:unprocessable_entity)

      # Translation asserts
      expect(response.body).to include("Cantidad máxima de caracteres: 50")


      #*******   Bank name already exists   *******#
      Bank.create! valid_attributes

      expect {
        post banks_url, params: {bank: valid_attributes}
      }.not_to change(Bank, :count) # Ensure that the Bank count doesn't change

      expect(response).to have_http_status(:unprocessable_entity)
      
      # Translation asserts
      expect(response.body).not_to include("Translation missing")
    end
  end

  describe "PUT #update" do
    it "updates a Bank" do
      bank = Bank.create! name: "Old bank"
      put bank_url(bank), params: {bank: valid_attributes}

      expect(Bank.last).to eq(assigns(:bank))
      expect(Bank.last.name).to eq("My bank")

      # Translation asserts
      follow_redirect!
      expect(response.body).not_to include("Translation missing")
    end
  end

  describe "DELETE #destroy" do
    it "destroys a Bank" do
      bank = Bank.create! valid_attributes
      expect { delete bank_url(bank) }.to change(Bank, :count).by(-1)

      # Translation asserts
      follow_redirect!
      expect(response.body).not_to include("Translation missing")
    end
  end
end