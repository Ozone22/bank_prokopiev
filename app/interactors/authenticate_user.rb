class AuthenticateUser
  include Interactor

  delegate :email, :password, :google_secret, to: :context

  def call
    user = User.find_by(email: email)
    if user && user.authenticate(password) && user.two_step_auth_check(google_secret)
      context.token = JWTWrapper.encode(user_id: user.id)
    else
      context.fail!
    end
  end
end
