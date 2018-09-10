Rails.application.routes.draw do
  get 'blocks/block_user'

  get 'blocks/unblock_user'

  devise_for :users, controllers: { passwords: 'users/passwords' , registrations: 'users/registrations', confirmations: 'users/confirmations'}
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :reports, :only => [:new, :create]

  resources :posts do
      resources :votes, :only => [:create, :update, :destroy]
  end

  match ':user/follow_user', to: 'relationships#follow_user', as: :follow_user, via: [:get, :post]
  match ':user/unfollow_user', to: 'relationships#unfollow_user', as: :unfollow_user, via: [:get, :post]
  #Calling follow_user_path will return an HTTP post response by invoking follow_user from the relationships controller

  #Match allows either action to be made when required (i.e. when signed in, it is a post method; however if not signed in it should be get [for now])

  match ':user/block_user', to: 'relationships#block_user', as: :block_user, via: [:get, :post]
  match ':user/unblock_user', to: 'relationships#unblock_user', as: :unblock_user, via: [:get, :post]

  #NOTE: The blocking and following routes used to be post rather than get

  get ':user/list_following', to: 'users#list_following', as: :list_following
  get ':user/list_followers', to: 'users#list_followers', as: :list_followers
  #This is temporary, primarily for testing purposes
  get ':user/list_blockers', to: 'users#list_blockers', as: :list_blockers
  get ':user/list_blocking', to: 'users#list_blocking', as: :list_blocking

  get ':user_id/change_password', to: 'users#change_password', as: :change_password
  get ':user_id/change_email', to: 'users#change_email', as: :change_email
  get ':user_id/change_username', to: 'users#change_username', as: :change_username

  patch ':user_id/update_password' => 'users#update_password'
  patch ':user_id/update_email' => 'users#update_email'
  patch ':user_id/update_username' => 'users#update_username'

  get '/sports', to: 'users#sports', as: :sports
  get '/funny', to: 'users#funny', as: :funny
  get '/gaming', to: 'users#gaming', as: :gaming
  get '/music', to: 'users#music', as: :music
  get '/pictures', to: 'users#pictures', as: :pictures
  get '/wtf', to: 'users#wtf', as: :wtf
  get '/food', to: 'users#food', as: :food
  get '/animals', to: 'users#animals', as: :animals
  get '/news', to: 'users#news', as: :news
  get '/learning', to: 'users#learning', as: :learning
  get '/fitness', to:'users#fitness', as: :fitness
  get '/nsfw', to: 'users#nsfw', as: :nsfw

  root 'users#index'
  #The root will not always be this, it should be the content- just testing to get signup working
end

#Server to bind to for ssl:

#rails s -b 'ssl://localhost:3000?key=localhost.key&cert=localhost.crt'
