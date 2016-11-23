Rails.application.routes.draw do
  namespace :v1, defaults: { format: :json } do
  	resources :users, only: %i(create show update) do
      resources :accounts, only: %i(index)
    end

    resources :accounts, only: %i(show create update destroy)
    resources :sessions, only: %i(create)

  	post 'sign_in', to: 'sessions#create'
    post 'sign_up', to: 'users#create'
  end
end