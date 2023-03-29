Rails.application.routes.draw do
  resources :states
  resources :cities do
    collection do
      get :load_2_frames
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
