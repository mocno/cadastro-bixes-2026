Rails.application.routes.draw do
  root to: 'bixes#index'
  resources :bixes, only: [] do
    collection do
      resources :confirmacoes, only: %i(index)
      get :emails
    end

    member do
      resources :confirmacoes, only: %i(create)
    end
  end
  get '/tutorial', to: 'others#tutorial'
  get '/bixes/contatos' => 'bixes#contatos', as: :contatos

  resources :bixes, except: [:edit]
  resources :confirmacoes, only: %i(destroy)
end
