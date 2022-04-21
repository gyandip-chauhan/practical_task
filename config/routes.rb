Rails.application.routes.draw do
  devise_for :users

  namespace :api, format: [:json] do
    namespace :auth do
      post '/signup' => "users#signup"
      post '/signin' => "users#signin"
    end

    resources :distances, only: [:index, :create]
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
