require "rails_helper"
require "rspec_api_documentation/dsl"

resource "Accounts" do
  include_context "current user signed in"

  subject(:response) { json_response_body }
  let(:account) { create(:account, customer: current_user) }

  before do
    header "Accept", "application/json"
    header "Authorization", "Bearer #{token}"
  end

  get "/v1/accounts/:id" do
    let(:id) { account.id }

    example_request "Get account" do
      expect(response_status).to eq 200
      expect(response).to be_a_account_representation(account)
    end
  end
end
