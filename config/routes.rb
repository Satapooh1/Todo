Rails.application.routes.draw do
  resources :categories do
    resources :tasks, except: [ :show ]
  end
  resources :tasks, except: [ :show ] do
    member do
      get "complete"
    end
  end

  root "tasks#index"
end
