Rails.application.routes.draw do
  # Rotas para as APIs Grape
  mount WalletApi => '/api'

  resources :extracts
  resources :wallets do
    post 'withdraw_or_deposit', on: :member
  end
  resources :users

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Define a rota raiz ("/")
  root 'users#index'
end
