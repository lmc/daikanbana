Daikanbana::Application.routes.draw do
  devise_for :users, :controllers => { :registrations => "registrations"}

  #resources :users, :only => [:new,:create], :controller => "registrations"

  resource :account, :only => [:edit,:update]

  root :to => "change_me#index"
end
