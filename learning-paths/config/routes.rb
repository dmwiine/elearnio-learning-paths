Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'learning_path/index'
      get 'learning_path/show'
      get 'learning_path/create'
      get 'learning_path/update'
      get 'learning_path/destroy'
    end
  end
  namespace :api do
    namespace :v1 do
      resources :talents, only: %i[index show create update destroy]
      resources :authors, only: %i[index show create update destroy]
      resources :courses, only: %i[index show create update destroy]
      resources :learning_paths, only: %i[index show create update destroy]
      resources :talent_learning_paths, only: %i[create update]
      resources :talent_course, only: %i[create update]
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
