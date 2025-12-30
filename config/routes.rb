Rails.application.routes.draw do

  ## Authors: Ayan Ahmad (K19002255), Kevin Quah (k1921877), Jae Min An (k19034574), Daniela Stanciu (k1922053), Mihaela Peneva (k19026170) 
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'front_pages#index'

  get '/current', to: 'front_pages#currentac'
  get '/cards/credit', to: 'front_pages#creditc'
  get '/contact', to: 'front_pages#contact'
  get '/about', to: 'front_pages#about'
  get '/covid', to: 'front_pages#covid'

  get '/admin', to: 'consoles#index'
  get '/login',   to: 'sessions#new'
  post '/login',   to: 'sessions#create'
  get '/loginsecure',   to: 'sessions#newsecure'
  post '/loginsecure',   to: 'sessions#secure'

  delete '/logout',  to: 'sessions#destroy'

  get '/signup', to: 'users#new'
  post '/user/secure', to: 'users#secure'
  get '/user/secure', to: 'users#show'
  get '/profile', to: 'users#show'

  get 'user_admin/:id/edit_password', to: 'user_admins#password_change'
  patch 'user_admin/:id/edit_password_action', to: 'user_admins#password_change_action'


  get 'transactions/:accid', to: 'transactions#index'
  get 'transactions/:accid/:id/', to: 'transactions#show'

  get 'transfers/:accid/new', to: 'transfers#new'
  post 'transfers/:accid/new', to: 'transactions#create'

  get 'transactions/:accid/random', to: 'account_admins#index'
  patch 'transactions/:accid/random', to: 'transaction_admins#random'

  resources :accounts , :except => [:show, :delete, :new]

  resources :account_admins do
    member do
      get :delete
    end
  end

  resources :currency_admins do
    member do
      get :delete
    end
  end

  resources :user_admins do
    member do
      get :delete
    end
  end

  resources :transaction_admins do
    member do
      get :delete
    end
  end

  resources :consoles

end
