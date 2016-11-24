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

  put "/v1/accounts/:id" do
    let(:id) { account.id }

    with_options scope: :account do
      parameter :account_type, "Account type(debit, credit)"
      parameter :account_number, "Account number(18 digits)"
      parameter :current_balance, "Current balance (default 0)"
    end

    let(:current_balance) { 120 }

    example_request "Update account balance" do
      expect(response_status).to eq 204
    end
  end
end
