Daikanbana::Application.routes.draw do
  devise_for :users

  root :to => "change_me#index"
end
