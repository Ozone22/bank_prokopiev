require "rails_helper"
require "rspec_api_documentation/dsl"

resource "Users" do
  include_context "current user signed in"

  subject(:response) { json_response_body }

  put "/v1/users/:user_id/security" do
    let!(:user_id) { current_user.id }

    example_request "Enable current user two step auth" do
      expect(response_status).to be 200
      expect(response).to be_a_google_qr_url_representation
      expect(current_user.reload.two_step_auth).to be_truthy
    end

    example "Disable current user two step auth" do
      current_user.toggle! :two_step_auth
      do_request
      expect(response_status).to be 204
      expect(current_user.reload.two_step_auth).to be_falsey
    end
  end
end
