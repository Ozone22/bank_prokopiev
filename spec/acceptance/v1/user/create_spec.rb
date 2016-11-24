require "rails_helper"
require "rspec_api_documentation/dsl"

resource "Users" do
  header "Accept", "application/json"

  subject(:response) { json_response_body }

  post "/v1/users" do
    with_options scope: :user, required: true do
      parameter :email, "Email"
      parameter :password, "Password"
      parameter :first_name, "First name"
      parameter :last_name, "Last name"
      parameter :phone, "Phone"
    end

    let(:user) { attributes_for :user }

    example "Registration with valid data" do
      do_request(user: user)
      expect(response).to be_a_session_representation
    end

    example "Registration with invalid data" do
      do_request(user: user.except(:password))
      expect(response_status).to eq 422
      expect(response_body).to be_an_error_representation
    end
  end
end
