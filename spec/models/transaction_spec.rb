require "rails_helper"

describe Transaction, type: :model do
  subject(:transaction) do
    attributes = attributes_for(:transaction)
    attributes[:sender_account] =  sender_account
    attributes[:recipient_account] = recipient_account
    described_class.new(attributes)
  end

  let(:sender_account) { create(:sender_account, current_balance: 100) }
  let(:recipient_account) { create(:recipient_account) }

  it { is_expected.to respond_to(:sender_account) }
  it { is_expected.to respond_to(:recipient_account) }
  it { is_expected.to respond_to(:amount) }
  it { is_expected.to respond_to(:created_at) }

  it { is_expected.to be_valid }

  it { is_expected.to validate_presence_of(:sender_account_id) }
  it { is_expected.to validate_presence_of(:recipient_account_id) }

  it { is_expected.to validate_presence_of(:amount) }
  it { is_expected.to validate_numericality_of(:amount).is_greater_than 0 }

  context "when not enough money for operation" do
    let(:sender_account) { create(:account, current_balance: 100) }
    let(:recipient_account) { create(:account, current_balance: 5) }

    before do
      transaction.sender_account = sender_account
      transaction.recipient_account = recipient_account
      transaction.amount = 110
      transaction.save
    end

    specify { expect(transaction).not_to be_valid }
  end
end
