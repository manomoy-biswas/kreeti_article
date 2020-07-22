Rails.application.routes.draw do
  root "home#index"
  get :user_dashboard, "users/dashboard"
  resources :users
  resources :sessions
  resources :articles do
    resources :comments do
      member do
        put :comment_like
      end
    end
    member do
      put :like
    end
    collection do
      get :search
      get :print_pdf
    end
  end
  resources :categories
end
