Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :users do
        get '/:id/dashboard', to: 'dashboard#show', as: 'dashboard'
        post '/:id/wines', to: 'wines#create', as: 'wines'
        delete '/:user_id/wines/:wine_id', to: 'dashboard#destroy'
      end
      namespace :wines do
        get '/search', to: 'search#index'
      end
      resources :wines, only: :show
    end
  end
end
