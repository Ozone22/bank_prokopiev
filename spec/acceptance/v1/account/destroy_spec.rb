require "rails_helper"
require "rspec_api_documentation/dsl"

resource "Accounts" do
  include_context "current user signed in"

  subject(:response) { json_response_body }

  delete "/v1/accounts/:id" do
    let(:id) { account.id }
    let(:account) { create(:account, customer: current_user) }

    example_request "Delete account" do
      expect(response_status).to be 204
    end
  end
end
