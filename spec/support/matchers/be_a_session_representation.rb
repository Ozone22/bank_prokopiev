RSpec::Matchers.define :be_a_session_representation do
  match do |json|
    expect(json).to be
    expect(json).to include('authentication_token')
  end
end
