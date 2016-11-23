FactoryGirl.define do
  factory :user do
    email
    first_name
    last_name
    phone
    password 'hardPassword1'
    password_confirmation 'hardPassword1'
  end
end