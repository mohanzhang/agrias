Agrias::Application.routes.draw do
  devise_for :users

  root :to => "terminal#index"

  match "echo", :to => "terminal#echo"
  
  resources :buffer_items do
    post :args, :on => :collection
  end

  resources :aspects do
    post :args, :on => :collection
  end
  
  resources :tasks do
    post :args, :on => :collection
    post :reset, :on => :member
    post :start, :on => :member
    post :wait, :on => :member
    post :complete, :on => :member
  end

  resources :appointments do
    post :args, :on => :collection
    post :attended, :on => :member
  end

  resource :visualization do
    get :priority
    get :table
  end
end
