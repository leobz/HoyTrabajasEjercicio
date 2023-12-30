require "rails_helper"

RSpec.describe "Banks Requests", type: :request do
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
    end
  end

  describe "GET #show" do
    it "returns a bank" do
      Bank.create! valid_attributes
      get bank_url(Bank.last)

      expect(response).to be_successful
      expect(Bank.last).to eq(assigns(:bank))
      expect(Bank.last.name).to eq("My bank")
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
    end
  end

  describe "PUT #update" do
    it "updates a Bank" do
      bank = Bank.create! name: "Old bank"
      put bank_url(bank), params: {bank: valid_attributes}

      expect(Bank.last).to eq(assigns(:bank))
      expect(Bank.last.name).to eq("My bank")
    end
  end

  describe "DELETE #destroy" do
    it "destroys a Bank" do
      bank = Bank.create! valid_attributes
      expect { delete bank_url(bank) }.to change(Bank, :count).by(-1)
    end
  end
end