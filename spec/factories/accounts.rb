FactoryGirl.define do
  factory :account do
    account_type 'debit'
    account_number
    current_balance 10
    customer
  end
end
