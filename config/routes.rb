Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :countries do 
  	post :import, on: :collection
  end

  root :to => "home#index"

end
