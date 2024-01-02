# Creates a Provider with defaults attributes
def create_test_provider(bank = create_test_bank(), name = "Test Provider")
  Provider.create!({
    nit: "100000000-0",
    name: name,
    contact_name: "Test Person",
    contact_phone: nil, # optional field
    account_number: nil, # optional field
    bank_id: bank.id
  })
end

# Creates a Bank with random name
def create_test_bank()
  Bank.create!(name: SecureRandom.urlsafe_base64(10))
end

# Creates a User with defaults attributes
def create_test_user()
  User.create!({
    email: "user@example.com",
    password: "password"
  })
end

# Creates a user and sign in
def sign_in_test_user()
  sign_in create_test_user()
end