module Accounts
  class CreateAccount
    include Interactor

    delegate :current_user, :account, to: :context

    def call
      account.customer = current_user
      account.account_number = Faker::Number.number 18
      account.save || context.fail!
    end
  end
end
