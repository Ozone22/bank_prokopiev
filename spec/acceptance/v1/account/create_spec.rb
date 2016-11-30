require "rails_helper"
require "rspec_api_documentation/dsl"

resource "Accounts" do
  include_context "current user signed in"

  subject(:response) { json_response_body }

  post "/v1/accounts" do
    with_options scope: :account do
      parameter :account_type, "Account type(debit, credit)", required: true
      parameter :current_balance, "Current balance (default 0)"
    end

    let(:account) { attributes_for :account }

    example "Create account with valid data" do
      do_request(account: account)
      expect(response_status).to be 201
    end
  end
end
