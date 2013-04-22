Rails.application.routes.draw do

  namespace :foreman_katello_engine do
    resources :activation_keys, :only => [:index]
    namespace :api do
      resources :environments, :only => [:show, :create]
    end
  end
end
