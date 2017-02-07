RSpec::Matchers.define :be_a_user_representation do |user|
  match do |json|
    response_attributes = user.attributes.slice %w(
      id
      email
      phone
      first_name
      last_name
      two_step_auth
    )

    expect(json).to be
    expect(json).to include_attributes(response_attributes)
  end
end
