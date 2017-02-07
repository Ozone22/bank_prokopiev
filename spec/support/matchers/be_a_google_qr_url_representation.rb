RSpec::Matchers.define :be_a_google_qr_url_representation do
  match do |json|
    expect(json).to be
    expect(json).to include("google_auth_url")
  end
end
