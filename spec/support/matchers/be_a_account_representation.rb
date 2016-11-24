RSpec::Matchers.define :be_a_account_representation do |account|
  match do |json|
    response_attributes = account.attributes.slice %w(
      id
      account_number
      account_type
      current_balance
      created_at
      closed_at
    )

    expect(json).to be
    expect(json).to include_attributes(response_attributes)
  end
end
