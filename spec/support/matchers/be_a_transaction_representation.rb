RSpec::Matchers.define :be_a_transaction_representation do |transaction|
  match do |json|
    response_attributes = transaction.attributes.slice %w(
      id
      amount
      recipient_account_id
      sender_account_id
      created_at
    )

    expect(json).to be
    expect(json).to include_attributes(response_attributes)
  end
end
