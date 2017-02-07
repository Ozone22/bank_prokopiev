module V1
  class TransactionsController < ApplicationController
    before_action :authenticate_user
    before_action :user_account, only: %i(create)

    expose(:transaction)
    expose(:transactions) { user_transactions.order(created_at: :desc) }

    def create
      Transactions::CreateTransaction.call(transaction: transaction)
      respond_with :v1, transaction
    end

    def index
      render json: transactions
    end

    def show
      render json: transaction
    end

    private

    def transaction_params
      params.require(:transaction).permit(:recipient_account_id, :sender_account_id, :amount)
    end

    def user_transactions
      current_user.transactions
    end

    def user_account
      head :forbidden unless current_user.accounts.include? transaction.sender_account
    end
  end
end
