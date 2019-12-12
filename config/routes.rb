Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/edit'
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"

    get "/signup", to: "users#new"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    post "/borrowed_details", to: "borrowed_details#create"
    delete "/logout", to: "sessions#destroy"

    resources :users
    resources :books
    resources :borroweds, except: %i(create new)
    resources :borrowed_details, only: %i(create destroy)
    resources :borroweds, only: %i(show)
    resources :comments, only: %i(create destroy)
    resources :account_activations, only: :edit
    resources :password_resets, except: %i(index show destroy)
  end
end
