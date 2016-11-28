module V1
  class TransactionSerializer < ApplicationSerializer
    belongs_to :recipient_account
    belongs_to :sender_account

    attributes :id, :amount, :created_at
  end
end
