Dmp40k::Application.routes.draw do
  
  Mercury::Engine.routes

  match 'user/edit' => 'users#edit', :as => :edit_current_user

#  match 'signup' => 'users#new', :as => :signup

  match 'logout' => 'sessions#destroy', :as => :logout

  match 'login' => 'sessions#new', :as => :login

  match '/rules' => 'pages#rules', :as => 'rules'

  match '/painting_contest' => 'pages#contest', :as => 'contest'

  match '/directions' => 'pages#directions', :as => 'directions'

  match '/admin' => 'admin#index'

  match '/tournaments/:id/pages/:id' => 'pages#update', :via => 'post'

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
      resources :tournament_pairings, :as => 'pairings', :only => [:index, :update]
    end
    resource :play
    resources :posts
    resources :pages
    resources :tournament_registrations, :path => "registrations" do
      member do
        get 'toggle_payment', :as => 'toggle_payment'
        get 'toggle_rosters'
        get 'toggle_rosters_validation'
        get 'toggle_accept'
      end
    end 
    member do
      get 'generate_pairings'
    end
  end
  
  namespace :admin do
    resources :players do
      collection do
        post 'import'
      end
    end
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

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
