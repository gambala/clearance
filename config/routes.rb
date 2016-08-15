if Clearance.configuration.routes_enabled?
  Rails.application.routes.draw do
    scope module: :web do
      scope module: :clearance do
        resources :passwords, only: [:new, :create]

        resources :users, only: Clearance.configuration.user_actions do
          resource :password, only: [:create, :edit, :update]
        end

        resource :session, only: [:create]

        delete :logout, to: 'sessions#destroy', as: :sign_out
        get :login, to: 'sessions#new', as: :sign_in

        if Clearance.configuration.allow_sign_up?
          get :register, to: 'users#new', as: :sign_up
        end
      end
    end
  end
end
