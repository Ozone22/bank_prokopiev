class AuthenticateUser
  include Interactor

  delegate :email, :password, to: :context

  def call
    user = User.find_by(email: email)
    if user && user.authenticate(password)
      context.token = JWTWrapper.encode(user_id: user.id)
    else
      context.fail!
    end
  end
end
