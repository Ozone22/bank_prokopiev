FactoryGirl.define do
  sequence(:email) { Faker::Internet.email }
  sequence(:first_name) { Faker::Name.first_name }
  sequence(:last_name) { Faker::Name.last_name }
  sequence(:phone) { Faker::Number.number(11) }
  sequence(:account_number) { Faker::Number.number(18) }
end
