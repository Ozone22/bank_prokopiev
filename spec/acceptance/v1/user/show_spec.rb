require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource 'Users' do
  include_context "current user signed in"

  before do
    header 'Accept', 'application/json'
    header 'Authorization', "Bearer #{token}"
  end

  subject(:response) { json_response_body }

  get "/v1/users/:id" do
    let(:id) { current_user.id }

    example_request 'Show current user data' do
      expect(response_status).to eql 200
      expect(response).to be_a_user_representation(current_user)
    end
  end
end