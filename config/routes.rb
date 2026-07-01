Rails.application.routes.draw do
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  # Liberadas as rotas de listagem, criação, atualização e exclusão
  resources :categories, only: [:index, :create, :update, :destroy]
  resources :transactions, only: [:index, :create, :update, :destroy]
  
  get "dashboard", to: "dashboard#index"
  get "up" => "rails/health#show", as: :rails_health_check
end