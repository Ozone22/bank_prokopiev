class Transaction < ApplicationRecord
  before_save { self.amount = amount.round(2) }

  belongs_to :recipient_account, class_name: "Account", foreign_key: "recipient_account_id"
  belongs_to :sender_account, class_name: "Account", foreign_key: "sender_account_id"

  validates :recipient_account_id, presence: true
  validates :sender_account_id, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validate :amount_validation

  private

  def amount_validation
    sender_account = Account.find_by(id: sender_account_id)
    return unless sender_account && amount && sender_account.current_balance < amount
    errors.add(:amount, I18n.t("activerecord.errors.attributes.amount.insufficient_funds"))
  end
end
