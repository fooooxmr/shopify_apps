Rails.application.routes.draw do
  root 'apps_pages#index'

  namespace :admin do
    resources :config, only: %i[], path: '/' do
      put '/', on: :collection, action: :update, as: :update
      get '/', on: :collection, action: :edit
    end
  end
end

