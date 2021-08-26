Rails.application.routes.draw do
  devise_for :users
  resources :asignaturas
  resources :grados
  resources :universidads
  resources :comunidads
  root 'static_pages#index'
  get 'static_pages/index'

  get '/universidads/scrape/:idUniversidad', to: "universidads#scrape" , as: "universidads_scrape"
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
