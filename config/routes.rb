Rails.application.routes.draw do
  get 'blocks/block_user'

  get 'blocks/unblock_user'

  devise_for :users
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :reports, :only => [:new, :create]

  post ':user/follow_user', to: 'relationships#follow_user', as: :follow_user
  post ':user/unfollow_user', to: 'relationships#unfollow_user', as: :unfollow_user
  #Calling follow_user_path will return an HTTP post response by invoking follow_user from the relationships controller

  post ':user/block_user', to: 'relationships#block_user', as: :block_user
  post ':user/unblock_user', to: 'relationships#unblock_user', as: :unblock_user

  get ':user/list_following', to: 'users#list_following', as: :list_following
  get ':user/list_followers', to: 'users#list_followers', as: :list_followers
  #This is temporary, primarily for testing purposes
  get ':user/list_blockers', to: 'users#list_blockers', as: :list_blockers
  get ':user/list_blocking', to: 'users#list_blocking', as: :list_blocking

  get ':user/change_password', to: 'users#change_password', as: :change_password


  #get ':user/report_list', to: 'users#report_list', as: :report_list

  root 'users#index'
  #The root will not always be this, it should be the content- just testing to get signup working
end
