RSpec::Matchers.define :be_an_error_representation do
  match do |json|
    expect(json).to be
    expect(json).to include("errors")
  end
end
