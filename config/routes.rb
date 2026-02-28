Rails.application.routes.draw do
  root to: 'others#tutorial'
  resources :bixes, only: [] do
    collection do
      resources :confirmacoes, only: :index
    end

    member do
      resources :confirmacoes, only: :create, as: :create_confirmacoes
      delete 'confirmacoes', to: 'confirmacoes#destroy', as: :destroy_confirmacoes
    end
  end
  get '/tutorial', to: 'others#tutorial'
  get '/bixes/emails', to: 'bixes#emails'

  resources :bixes
end
