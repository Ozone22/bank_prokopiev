module V1
	class PasswordsController < ApplicationController
		def create
			result = Passwords::InitTokens.call(user_create_params)
			
			if result.success?
				UserMailer.password_reset(result.user).deliver_later
				head :ok	
			else
				head :unprocessable_entity
			end
		end

		def update
			user = User.find_by(password_reset_token: params[:id])
			return head :not_found unless user
			if user.reset_token_sended_at > 2.hours.ago
				user.update_attributes(user_update_params)
				render json: user
			else
				render json: { errors: "Reset time expired" }, status: :unprocessable_entity
			end
		end

		private

		def user_create_params
			params.require(:user).permit(:email, :google_secret)
		end

		def user_update_params
			params.require(:user).permit(:password)
		end
	end
end
