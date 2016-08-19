if Clearance.configuration.routes_enabled?
  Rails.application.routes.draw do
    scope module: :web do
      scope module: :clearance do
        resources :passwords, only: [:new, :create]

        resources :users, only: Clearance.configuration.user_actions do
          resource :password, only: [:create, :edit, :update]
        end

        resource :session, only: [:create]

        delete :logout, to: 'sessions#destroy'
        get :login, to: 'sessions#new'
        get :register, to: 'users#new' if Clearance.configuration.allow_sign_up?
      end
    end
  end
end
