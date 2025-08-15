Rails.application.routes.draw do
  get "profiles/show"
  get "profiles/edit"
  get "profiles/update"
  devise_for :users
  root to: "home#index"

  resource :profile, only: [ :show, :edit, :update ]
  resources :recipes do
    member do
      get :categories_async
      get :tags_async
      get :ingredients_async
    end
  end
end
