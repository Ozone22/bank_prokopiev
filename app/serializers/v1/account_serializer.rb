module V1
  class AccountSerializer < ApplicationSerializer
    belongs_to :customer

    attributes :id, :account_type, :account_number, :current_balance,
      :closed_at, :created_at
  end
end
