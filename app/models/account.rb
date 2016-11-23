class Account < ApplicationRecord
  before_save { self.current_balance = current_balance.round(2) }

  belongs_to :customer, class_name: 'User'

  validates :account_type, presence: true
  validates :customer_id, presence: true
  validates :account_number, presence: true, uniqueness: { case_sensitive: false },
            length: { is: 18 }, numericality: { only_integer: true }
  validates :current_balance, presence: true, numericality: true

  enum status: %i(debit credit)
end
