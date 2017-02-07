module V1
	class SecuritiesController < ApplicationController
		before_action :authenticate_user
		before_action :correct_user

		expose(:user)

		def update
			if user.two_step_auth?
				user.toggle! :two_step_auth
				head :no_content
			else
				activate_user_2fa
				render json: { google_auth_url: user.google_qr_uri, google_secret: user.google_secret }, status: :ok
			end
		end

		private

		def activate_user_2fa
			user.toggle :two_step_auth
			user.google_secret = GoogleAuthenticatorRails.generate_secret
			user.save!(validate: false)
		end
	end
end
