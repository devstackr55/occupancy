Rails.application.routes.draw do

  devise_for :users, :skip => [:registrations]
  as :user do
    get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
    put 'users' => 'devise/registrations#update', :as => 'user_registration'
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  resources :skills do
    resources :employees, only: [:index] do
      collection do
        get :statistics
      end
    end
  end

  resources :employees, except: [:index] do
    collection do
      get :search
    end
    # resources :employee_projects
    resources :timesheets
  end

  resources :clients
  resources :projects do
    resources :employee_projects
    resources :invoices, except: [:edit] do
      collection do
        get :timesheets
      end
      member do
        put :capture_payment
      end
    end
    collection do
      get :plan
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html


  root to: 'dashboard#index'
end
