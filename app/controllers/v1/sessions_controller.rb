module V1
  class SessionsController < ApplicationController
    def create
      result = AuthenticateUser.call(session_params)

      if result.success?
        respond_with_token result.token
      else
        head :unauthorized
      end
    end

    private

    def session_params
      params.require(:session).permit(:email, :password)
    end
  end
end
