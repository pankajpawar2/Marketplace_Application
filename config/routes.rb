Rails.application.routes.draw do

  devise_for :users
  root 'pages#home'
  get '/categories',to:'products#index',as:'categories'
  post '/categories',to:'products#create_new_category'

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

  get '/new/category',to:'products#new_category',as:'categories_new'

  get '/product/:price',to:'products#product_by_price',as:'product_by_price'

  get '/new/products',to:'products#show_new_product',as:'show_new_product'

  post "/payments/webhook", to: "payments#webhook"

  # stripe

  get "/payments/success", to: "payments#success"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
