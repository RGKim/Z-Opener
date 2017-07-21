Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  resources :images do
  resources :orders
  end
  resources :images
  root 'devices#index'
  get '/order_page' => 'images#order_page'
  get '/devices' => 'devices#index'
  get '/welcome/index' => 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
