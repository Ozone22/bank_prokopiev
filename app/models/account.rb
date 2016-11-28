class Account < ApplicationRecord
  before_save { self.current_balance = current_balance.round(2) }

  belongs_to :customer, class_name: "User"
  has_many :sender_transactions, class_name: "Transaction", foreign_key: "sender_account_id"
  has_many :recipient_transactions, class_name: "Transaction", foreign_key: "recipient_account_id"

  scope :transactions, -> (account_id) {
    Transaction.where("sender_account_id = ? OR recipient_account_id = ?", account_id, account_id)
  }

  validates :account_type, presence: true
  validates :customer_id, presence: true
  validates :account_number, presence: true, uniqueness: { case_sensitive: false },
            length: { is: 18 }, numericality: { only_integer: true }
  validates :current_balance, presence: true, numericality: true

  enum account_type: %i(debit credit)

  def transactions
    Account.transactions(id)
  end
end
