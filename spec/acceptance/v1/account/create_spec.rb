require "rails_helper"
require "rspec_api_documentation/dsl"

resource "Accounts" do
  include_context "current user signed in"

  subject(:response) { json_response_body }

  before do
    header "Accept", "application/json"
    header "Authorization", "Bearer #{token}"
  end

  post "/v1/accounts" do
    with_options scope: :account do
      parameter :account_type, "Account type(debit, credit)", required: true
      parameter :account_number, "Account number(18 digits)", required: true
      parameter :current_balance, "Current balance (default 0)"
    end

    let(:account) { attributes_for :account }

    example "Create account with valid data" do
      do_request(account: account)
      expect(response_status).to eq 201
    end

    example "Create account with invalid data" do
      do_request(account: account.except(:account_number))
      expect(response_status).to eql 422
      expect(response).to be_an_error_representation
    end
  end
end
