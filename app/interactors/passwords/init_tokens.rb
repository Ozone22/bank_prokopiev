module Passwords
  class InitTokens
    include Interactor

    delegate :email, :google_secret, to: :context

    def call
      user = User.find_by(email: email)
      if user && user.two_step_auth_check(google_secret)
        set_token user
        context.user = user
      else
        context.fail!
      end
    end

    private

    def set_token(user)
      user.password_reset_token = SecureRandom.urlsafe_base64
      user.reset_token_sended_at = Time.zone.now
      user.save!(validate: false)
    end
  end
end
