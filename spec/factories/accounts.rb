FactoryGirl.define do
  factory :account, aliases: %i(sender_account recipient_account) do
    account_type "debit"
    account_number
    current_balance 10
    customer
  end
end
