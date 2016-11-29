require "rails_helper"
require "rspec_api_documentation/dsl"

resource "Accounts" do
  include_context "current user signed in"

  subject(:response) { json_response_body }

  get "/v1/users/:user_id/accounts" do
    let(:user_id) { current_user.id }
    let!(:account) { create(:account, customer: current_user) }

    example_request "Get user accounts" do
      expect(response_status).to be 200
      expect(response["accounts"].first).to be_a_account_representation(account)
    end
  end
end
