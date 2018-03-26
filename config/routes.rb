Rails.application.routes.draw do
  devise_for :users
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  post ':user/follow_user', to: 'relationships#follow_user', as: :follow_user
  post ':user/unfollow_user', to: 'relationships#unfollow_user', as: :unfollow_user
  #Calling follow_user_path will return an HTTP post response by invoking follow_user from the relationships controller

  get ':user/list_following', to: 'users#list_following', as: :list_following
  get ':user/list_followers', to: 'users#list_followers', as: :list_followers
  #This is temporary, primarily for testing purposes

  get ':user/change_password', to: 'users#change_password', as: :change_password

  #get ':user/follow', to: 'users#follow', as: :follow
  root 'users#index'
  #The root will not always be this, it should be the content- just testing to get signup working
end
