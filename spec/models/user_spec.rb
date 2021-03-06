require "rails_helper"

describe User, type: :model do
  subject(:user) { described_class.new(attributes_for(:user)) }

  it { is_expected.to respond_to(:email) }
  it { is_expected.to respond_to(:password) }
  it { is_expected.to respond_to(:first_name) }
  it { is_expected.to respond_to(:last_name) }
  it { is_expected.to respond_to(:middle_name) }
  it { is_expected.to respond_to(:phone) }
  it { is_expected.to respond_to(:created_at) }
  it { is_expected.to respond_to(:accounts) }
  it { is_expected.to respond_to(:sended_transactions) }
  it { is_expected.to respond_to(:received_transactions) }
  it { is_expected.to respond_to(:transactions) }
  it { is_expected.to respond_to(:two_step_auth) }
  it { is_expected.to respond_to(:password_reset_token) }
  it { is_expected.to respond_to(:reset_token_sended_at) }

  it { is_expected.to be_valid }

  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email).case_insensitive }

  it { is_expected.to validate_presence_of(:first_name) }
  it { is_expected.to validate_presence_of(:last_name) }

  it { is_expected.to validate_presence_of(:phone) }
  it { is_expected.to validate_length_of(:phone).is_equal_to(11) }
  it { is_expected.to validate_uniqueness_of(:phone).case_insensitive }
  it { is_expected.to validate_numericality_of(:phone).only_integer }
end
