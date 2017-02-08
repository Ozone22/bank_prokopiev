module V1
  class AccountsController < ApplicationController
    before_action :authenticate_user
    before_action :correct_user, only: %i(index)
    before_action :account_owner, only: %i(show update destroy)

    expose(:user)
    expose(:account)
    expose(:accounts) { paginated_accounts }

    def show
      respond_with :v1, account
    end

    def create
      Accounts::CreateAccount.call(current_user: current_user, account: account)
      respond_with :v1, account
    end

    def index
      render json: accounts
    end

    def update
      account.update_attributes(account_update_params)
      respond_with :v1, account
    end

    def destroy
      account.destroy!
      head :no_content
    end

    private

    def paginated_accounts
      user.accounts.page(params[:page]).per(params[:per_page] || 5)
    end

    def account_owner
      head :forbidden unless account.customer == current_user
    end

    def account_params
      params.require(:account).permit(:account_type, :current_balance)
    end

    def account_update_params
      params.require(:account).permit(:current_balance)
    end
  end
end
