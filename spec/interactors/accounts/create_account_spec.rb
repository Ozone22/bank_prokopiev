require "rails_helper"

describe Accounts::CreateAccount do
  describe ".call" do
    let(:current_user) { create :user }
    let(:account) { Account.new(current_balance: 100, account_type: 'debit') }

    context "create account" do
      subject(:result) do
        described_class.call(
          current_user: current_user,
            account: account
        ).account
      end

      it { expect(result.customer).to be_eql current_user }
      it { expect(result.account_number).not_to be_nil }
    end
  end
end
