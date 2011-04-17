Agrias::Application.routes.draw do
  root :to => "terminal#index"

  match "echo", :to => "terminal#echo"
  
  resources :buffer_items
end
