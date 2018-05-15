Rails.application.routes.draw do
 
  root 'links#index'

  resources :links, except: :index do
    resources :comments, only: [:create, :edit, :update, :destroy]
    post :upvote, on: :member
    post :downvote, on: :member
  end

  get '/newcomments' => 'comments#index'
  get '/newest' => 'links#newest', as: :newest_links
  get "/:page" => "static_pages#about"
  get '/links/next', 'links#next'

  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end

  resources :users, only: [:new, :create]
  
  namespace 'v0', format: :json do
    resources :links, only: [:show, :create]
    resources :comments, only: [:show]
  end
end