Rails.application.routes.draw do
  match "/404", :to => "errors#not_found", :via => :all
  match "/500", :to => "errors#internal_server_error", :via => :all

 devise_for :users, :controllers => { registrations: 'registrations' }
  root to: 'articles#index'
  devise_scope :user do
  get '/users/sign_out' => 'devise/sessions#destroy'
  
end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :articles
  resources :profile
  resources :articles do
  resources :comments
end
end
