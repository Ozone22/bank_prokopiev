module V1
  class UsersController < ApplicationController
    before_action :authenticate_user, except: %i(create)
    before_action :correct_user, except: %i(create)

    expose(:user)

    def create
      if user.save
        token = JWTWrapper.encode(user_id: user.id)
        respond_with_token token
      else
        respond_with :v1, user
      end
    end

    def update
      if user.update_attributes(user_params)
        head :no_content
      else
        respond_with :v1, user
      end
    end

    def show
      render json: user
    end

    private

    def user_params
      params.require(:user).permit(
        :first_name,
        :middle_name,
        :last_name,
        :email,
        :password,
        :phone
      )
    end
  end
end
