Rails.application.routes.draw do


  #main page
  root 'static_pages#home'

  #get 'static_pages/about'
  #get 'static_pages/home'
  #get 'static_pages/help'
  #get 'static_pages/contact'

  get 'about', to: 'static_pages#about'
  get 'help', to: 'static_pages#help'
  get 'contact', to: 'static_pages#contact'

  #signup page

  #get 'users/new' to: '/signup'
  #wrong way, had it backwards

  get 'signup', to: 'users#new' # correct way
  post 'signup', to: 'users#create'

  #adds a full restful url
  resources :users

end
