Rails.application.routes.draw do

  devise_for :users
  root 'pages#home'
  get '/categories',to:'products#index',as:'categories'
  get '/categories/:id',to:'products#show',as:'category'

  get '/products/:id',to:'products#show_product',as:'products'
  delete '/products/:id',to:'products#delete'
  put '/products/:id',to:'products#update'
  patch '/products/:id',to:'products#update'
  post '/products/:id',to:'products#new_comment'

  get '/products/:id/edit',to:'products#edit',as:'edit_product'

  get '/new/product',to:'products#new',as:'new_product'
  post '/new/product',to:'products#create'

  get 'user/products',to:'products#show_user_product',as:'user_products'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
