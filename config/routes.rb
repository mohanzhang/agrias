Agrias::Application.routes.draw do
  devise_for :users

  root :to => "terminal#index"

  match "echo", :to => "terminal#echo"
  
  resources :buffer_items
  resources :aspects
  
  resources :tasks do
    post :completed, :on => :member
  end

  resources :appointments do
    post :attended, :on => :member
  end

  resource :visualization do
    get :priority
  end
end
