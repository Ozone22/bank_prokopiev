require "rails_helper"
require "rspec_api_documentation/dsl"

resource "Transactions" do
  include_context "current user signed in"

  subject(:response) { json_response_body }

  post "/v1/transactions" do
    with_options scope: :transaction, required: true do
      parameter :recipient_account_id, "Recipient account id"
      parameter :sender_account_id, "Sender account id"
      parameter :amount, "Amount(greater than 0)"
    end

    let(:sender_account) { create(:account, customer: current_user, current_balance: 100) }
    let(:recipient_account) { create(:account, customer: create(:user), current_balance: 5) }
    let(:transaction) do
      attributes_for(:transaction,
        sender_account_id: sender_account.id,
        recipient_account_id: recipient_account.id,
        amount: 50)
    end

    example "Create transaction with valid data" do
      do_request(transaction: transaction)
      expect(response_status).to be 201
      expect(sender_account.reload.current_balance).eql? 50
      expect(recipient_account.reload.current_balance).eql? 55
    end

    example "Create transaction with invalid data" do
      do_request(transaction: transaction.except(:recipient_account_id))
      expect(response_status).to be 422
      expect(response).to be_an_error_representation
    end
  end
end
