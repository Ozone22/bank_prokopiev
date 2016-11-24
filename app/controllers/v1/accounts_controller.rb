module V1
  class AccountsController < ApplicationController
    before_action :authenticate_user
    before_action :correct_user, only: %i(index)
    before_action :account_owner, only: %i(show update destroy)

    expose(:user)
    expose(:account)
    expose(:accounts) { user.accounts }

    def show
      respond_with :v1, account
    end

    def create
      account.customer = current_user
      if account.save
        head :created
      else
        respond_with :v1, account
      end
    end

    def index
      render json: accounts
    end

    def update
      if account.update_attributes(account_params)
        head :no_content
      else
        respond_with :v1, account
      end
    end

    def destroy
      account.destroy!
      head :no_content
    end

    private

    def account_owner
      head :forbidden unless account.customer == current_user
    end

    def account_params
      params.require(:account).permit(:account_type, :account_number, :current_balance)
    end
  end
end
