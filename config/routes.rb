Rails.application.routes.draw do
  resources :clients do
    collection do
      get 'dashboard', to: 'clients#dashboard'
    end
    resources :deposits
  end
end
