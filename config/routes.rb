Daikanbana::Application.routes.draw do
  devise_for :users, :path_prefix => "/devise", :as => "devise" #namespace for devise so we can use our own routes

  resources :users, :only => [:new,:create], :controller => "registrations"

  root :to => "change_me#index"
end
