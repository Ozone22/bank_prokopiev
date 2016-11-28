class User < ApplicationRecord
  before_save { email.downcase! }

  has_many :accounts, foreign_key: "customer_id"
  has_many :sended_transactions, through: :accounts, source: :sender_transactions
  has_many :received_transactions, through: :accounts, source: :recipient_transactions

  validates :email, presence: true, email: true,
            uniqueness: { case_sensitive: false }
  validates :password, presence: true, password: true,
            length: { minimum: 5, maximum: 100 }
  validates :first_name, :last_name, presence: true
  validates :phone, presence: true, uniqueness: { case_sensitive: false },
            length: { is: 11 }, numericality: { only_integer: true }

  has_secure_password

  def transactions
    Transaction
      .joins(
        "INNER JOIN accounts " \
          "ON accounts.id = transactions.recipient_account_id " \
          "OR accounts.id = transactions.sender_account_id"
      ).where("accounts.customer_id = ?", id).distinct
  end
end
