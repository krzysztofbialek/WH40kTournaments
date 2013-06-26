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
    resources :tournament_registrations, :path => "registrations" do
      collection do
        get 'players'
      end
      member do
        get 'toggle_payment', :as => 'toggle_payment'
        get 'toggle_rosters'
        get 'toggle_rosters_validation'
        get 'toggle_accept'
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
    root :to => 'rank_places#index'
  end

  root :to => 'tournaments#index'
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

end
