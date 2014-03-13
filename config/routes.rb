Dmp40k::Application.routes.draw do
  
  mount Mercury::Engine => '/'

  Mercury::Engine.routes

  match 'user/edit' => 'users#edit', :as => :edit_current_user

  match 'signup' => 'users#new', :as => :signup

  match 'logout' => 'sessions#destroy', :as => :logout

  match 'login' => 'sessions#new', :as => :login

  match '/rules' => 'pages#rules', :as => 'rules'

  match '/painting_contest' => 'pages#contest', :as => 'contest'

  match '/directions' => 'pages#directions', :as => 'directions'

  match '/admin' => 'admin#index'

  resources :players do
    resources :tournament_registrations 
  end

  resources :sessions

  resources :users

  resources :teams

  resources :hostel_bookings do
    member do
      get 'toggle_payment'
    end
  end

  
  resources :tournaments do
    namespace :play do
      resources :players
      resources :results 
      resources :tournaments
      resources :tournament_pairings, :as => 'pairings', :only => [:index, :update, :show]
    end
    resource :play
    resources :posts
    resources :pages do
      member { post :mercury_update }
    end
    
    resources :team_registrations do
      member do
        get 'toggle'
      end
    end
      
    resources :tournament_registrations, :path => "registrations" do
      collection do
        get 'players'
      end
      member do
        get 'toggle_payment', :as => 'toggle_payment'
        get 'toggle_rosters'
        get 'toggle_rosters_validation'
      end
    end 
    member do
      get 'generate_pairings'
      get 'results'
      get 'current_round'
      get 'generate_rank_csv'
    end
  end
  

  

  namespace :admin do
    resources :players do
      collection do
        post 'import'
      end
    end
    
    resources :tournaments do
      member { post 'add_to_rank' }
    end  
  
    root :to => 'tournaments#index'
  end

  namespace :rank do
    resources :rank_places, path: 'player_results', as: 'player_results'
    root :to => 'rank_places#index'
  end

  root :to => 'tournaments#index'
end
