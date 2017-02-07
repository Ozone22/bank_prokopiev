FactoryGirl.define do
  factory :user, aliases: %i(customer) do
    email
    first_name
    last_name
    phone
    password "hardPassword1"
    password_confirmation "hardPassword1"

    trait :forgotted_password do
    	reset_token_sended_at
    	password_reset_token { generate(:reset_token) }
  	end
  end
end
