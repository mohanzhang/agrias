Agrias::Application.routes.draw do
  devise_for :users

  root :to => "terminal#index"

  match "echo", :to => "terminal#echo"
  
  resources :buffer_items
  resources :aspects
  
  resources :tasks do
    post :reset, :on => :member
    post :start, :on => :member
    post :wait, :on => :member
    post :complete, :on => :member
  end

  resources :appointments do
    post :attended, :on => :member
  end

  resource :visualization do
    get :priority
    get :table
  end
end
