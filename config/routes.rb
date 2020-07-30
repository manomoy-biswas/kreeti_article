Rails.application.routes.draw do
  root "home#index"
  get :overview, "home/overview"
  resources :users
  resources :sessions
  resources :articles do
    resources :comments, only: [:create, :index, :new]
    member do
      put :like
    end
    collection do
      get :search
      get :print_pdf
      get :filtered_article
    end
  end
  resources :comments do
    member do
      put :comment_like
    end
  end
  resources :categories
end
