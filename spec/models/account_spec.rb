require "rails_helper"

describe Account, type: :model do
  subject(:account) do
    attributes = attributes_for(:account)
    attributes[:customer] =  customer
    described_class.new(attributes)
  end

  let(:customer) { create(:user) }

  it { is_expected.to respond_to(:customer) }
  it { is_expected.to respond_to(:account_type) }
  it { is_expected.to respond_to(:account_number) }
  it { is_expected.to respond_to(:current_balance) }
  it { is_expected.to respond_to(:closed_at) }
  it { is_expected.to respond_to(:sender_transactions) }
  it { is_expected.to respond_to(:recipient_transactions) }
  it { is_expected.to respond_to(:transactions) }

  it { is_expected.to be_valid }

  it { is_expected.to validate_presence_of(:customer_id) }
  it { is_expected.to validate_presence_of(:account_type) }

  it { is_expected.to validate_presence_of(:account_number) }
  it { is_expected.to validate_length_of(:account_number).is_equal_to(18) }
  it { is_expected.to validate_uniqueness_of(:account_number).case_insensitive }
  it { is_expected.to validate_numericality_of(:account_number).only_integer }

  it { is_expected.to validate_presence_of(:current_balance) }
  it { is_expected.to validate_numericality_of(:current_balance) }

  it { is_expected.to define_enum_for(:account_type).with(%i(debit credit)) }

  context "round balance before save" do
    before do
      account.current_balance = 123.4523
      account.save
    end

    specify { expect(account.current_balance).to eql(123.45) }
  end
end
