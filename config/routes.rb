Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :blog, only: [:index]

  root to: "blog#index"
end
