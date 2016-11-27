FactoryGirl.define do
  factory :transaction do
    sender_account
    recipient_account
    amount 10
  end
end
