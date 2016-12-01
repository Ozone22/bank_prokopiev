module Transactions
  class CreateTransaction
    include Interactor

    delegate :transaction, to: :context

    def call
      create_transaction if transaction.valid?
      context.fail! unless transaction.persisted?
    end

    private

    def create_transaction
      ActiveRecord::Base.transaction do
        transaction.save
        sender_subtraction_means(transaction.sender_account_id, transaction.amount)
        recipient_receipt_funds(transaction.recipient_account_id, transaction.amount)
      end
    end

    def sender_subtraction_means(account_id, amount)
      sender_account = Account.find_by(id: account_id)
      sender_account.current_balance -= amount
      sender_account.save
    end

    def recipient_receipt_funds(account_id, amount)
      recipient_account = Account.find_by(id: account_id)
      recipient_account.current_balance += amount
      recipient_account.save
    end
  end
end
