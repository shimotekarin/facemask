Rails.application.routes.draw do
  devise_for :users, controllers: {   registrations: 'users/registrations',
                                      sessions: 'users/sessions' }
  resources :users, only: [:show] 
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
  get 'masks/:mask_id/likes' => 'likes#create'
  get 'masks/:mask_id/likes/:id' => 'likes#destroy'


  resources :masks do
    get :drafts
    resources :likes, only: [:create, :destroy]
  end

  get 'masks' => 'masks#top'
  post 'masks/:id/edit' => 'masks#edit'
  root 'masks#top'
end