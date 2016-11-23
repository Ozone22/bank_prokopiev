class User < ApplicationRecord
  before_save { email.downcase! }

  has_many :accounts, foreign_key: 'customer_id'

  validates :email, presence: true, email: true,
            uniqueness: { case_sensitive: false }

  validates :password, presence: true, password: true,
            length: { minimum: 5, maximum: 100 }

  validates :first_name, :last_name, presence: true

  validates :phone, presence: true, uniqueness: { case_sensitive: false },
            length: { is: 11 }, numericality: { only_integer: true }

  has_secure_password
end
