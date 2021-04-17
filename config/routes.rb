Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :users do
        get '/:id/dashboard', to: 'dashboard#show', as: 'dashboard'
      end
    end
  end
end
