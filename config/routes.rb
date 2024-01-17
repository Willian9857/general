Rails.application.routes.draw do
  resources :clients do
    resources :deposits, only: [:new, :create]
  end
  
  get 'dashboard', to: 'clients#dashboard'  
end
