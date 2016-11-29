shared_context "current user signed in" do
  let(:current_user) { create :user }
  let(:token) { JWTWrapper.encode(user_id: current_user.id) }

  before { header "Authorization", "Bearer #{token}" }
end
