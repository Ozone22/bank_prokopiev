require "rails_helper"
require "rspec_api_documentation/dsl"

resource "Sessions" do
  header "Accept", "application/json"

  subject(:response) { json_response_body }

  post "/v1/sign_in" do
    let(:user) { create :user }

    with_options scope: :session do
      parameter :email, "Email", required: true
      parameter :password, "Password", required: true
      parameter :google_secret, "Google auth code"
    end

    let(:email) { user.email }

    example_request "Sign in with valid password", session: { password: "hardPassword1" } do
      expect(response).to be_a_session_representation
    end

    example_request "Sign in with invalid password", session: { password: "" } do
      expect(response_status).to be 401
    end
  end
end
