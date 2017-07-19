Rails.application.routes.draw do
  resources :images do
  resources :orders
  end
  resources :devices
  resources :images
  root 'welcome#index'
  get '/order_page' => 'images#order_page'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
