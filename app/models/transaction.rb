class Transaction < ApplicationRecord
  before_save { self.amount = amount.round(2) }

  belongs_to :recipient_account, class_name: "Account", foreign_key: "recipient_account_id"
  belongs_to :sender_account, class_name: "Account", foreign_key: "sender_account_id"

  validates :recipient_account_id, presence: true
  validates :sender_account_id, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }
end
