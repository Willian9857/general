Rails.application.routes.draw do
  resources :clients    
  get 'dashboard', to: 'clients#dashboard'  
end