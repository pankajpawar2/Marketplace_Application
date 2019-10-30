Rails.application.routes.draw do

  devise_for :users
  root 'pages#home'
  get '/categories',to:'products#index',as:'categories'
  get '/categories/:id',to:'products#show',as:'category'

  get '/products/:id',to:'products#show_product',as:'products'
  delete '/products/:id',to:'products#delete'
  post '/products/:id',to:'products#new_comment'

  get '/new/product',to:'products#new',as:'new_product'
  post '/new/product',to:'products#create'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
