module V1
  class UserSerializer < ApplicationSerializer
    has_many :accounts

    attributes :id, :email, :first_name, :last_name, :phone, :two_step_auth
  end
end
