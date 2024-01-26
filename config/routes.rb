Rails.application.routes.draw do
  resources :clients do
    resources :deposits
  end

  get 'dashboard', to: 'clients#dashboard'
end
