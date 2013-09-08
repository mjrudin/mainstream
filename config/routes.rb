Mainstream::Application.routes.draw do
  
  resources :urls
  root to: "urls#index"
  
end
