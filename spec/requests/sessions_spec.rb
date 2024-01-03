require 'rails_helper'
require 'support_helper'

RSpec.describe "User Authentication", type: :request do
  let(:user) { create_test_user() }

  describe "Login" do
    it "allows a user to log in" do
      post user_session_path, params: { user: { email: user.email, password: user.password } }
      follow_redirect!

      expect(response.body).to include('Sesión iniciada')
    end

    it "rejects login with incorrect credentials" do
      post user_session_path, params: { user: { email: user.email, password: 'wrong_password' } }

      expect(response.body).to include('Email o contraseña inválidos')
    end
  end

  describe "Logout" do
    it "allows a logged-in user to log out" do
      sign_in user
      delete destroy_user_session_path

      follow_redirect!
      # Extra follow_redirect is needed due root_path is protected and redirects to login
      follow_redirect!

      expect(response.body).to include('Tienes que iniciar sesión o registrarte para poder continuar')
    end
  end

  describe "Registration" do
    it "allows a user to register" do
      attrs = {
        email: "someuser@example.com",
        password: "123456" ,
        password_confirmation: "123456"
      }

      post "/users", params: { user: attrs }
      follow_redirect!

      expect(response.body).to include('Bienvenido. Tu cuenta fue creada')
    end
  end
end