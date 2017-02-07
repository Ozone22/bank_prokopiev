require "rails_helper"
require "rspec_api_documentation/dsl"

resource "Users" do
  subject(:response) { json_response_body }

  let(:user) { create(:user) }
  let(:email) { user.email }

  post "/v1/users/passwords" do
    with_options scope: :user do
      parameter :email, "Email", required: true
      parameter :google_secret, "Google auth code"
    end

    example_request "Send email with reset instructions" do
      expect(user.reload.password_reset_token).not_to be_falsey
      expect(user.reset_token_sended_at).not_to be_falsey
      expect(response_status).to be 200
    end
  end
end
