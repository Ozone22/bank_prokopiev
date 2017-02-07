require "rails_helper"
require "rspec_api_documentation/dsl"

resource "Users" do
  subject(:response) { json_response_body }

  let(:user) { create(:user, :forgotted_password) }

  put "/v1/users/passwords/:id" do
    let(:id) { user.password_reset_token }

    with_options scope: :user, required: true do
      parameter :password, "Password"
    end

    let!(:password) { "New_pass_1" }

    example_request "Update password" do
      expect(response_status).to be 200
    end
  end
end
