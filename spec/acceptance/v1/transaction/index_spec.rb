require "rails_helper"
require "rspec_api_documentation/dsl"

resource "Transactions" do
  include_context "current user signed in"

  subject(:response) { json_response_body }

  get "/v1/transactions" do
    let!(:sender_account) { create(:account, customer: current_user) }
    let!(:recipient_account) { create(:account, customer: create(:user)) }
    let!(:transaction) do
      create(:transaction,
             sender_account: sender_account,
             recipient_account: recipient_account)
    end

    example_request "Get user accounts" do
      expect(response_status).to be 200
      expect(response["transactions"].first).to be_a_transaction_representation(transaction)
    end
  end
end
