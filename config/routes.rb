Rails.application.routes.draw do
  root "home#index"
  get :user_dashboard, "users/dashboard"
  resources :users
  resources :sessions
  resources :articles do
    resources :comments
    collection do
      get :search
      get :print_pdf
    end
  end

  resources :categories
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
