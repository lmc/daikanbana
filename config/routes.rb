Daikanbana::Application.routes.draw do
  devise_for :users, :controllers => { :registrations => "registrations"}

  resource :account, :only => [:edit,:update]

  root :to => "account#index"
end
