KappaDelta::Application.routes.draw do

  mount Bootsy::Engine => '/bootsy', as: 'bootsy'
  # This line mounts Forem's routes at /forums by default.
  # This means, any requests to the /forums URL of your application will go to Forem::ForumsController#index.
  # If you would like to change where this extension is mounted, simply change the :at option to something different.
  #
  # We ask that you don't use the :as option here, as Forem relies on it being the default of "forem"
  mount Forem::Engine, :at => '/forums'

  # Root
  root 'static_pages#home'

  # Static pages
  match 'member-home',    to: 'static_pages#home_member', via: 'get'
  match 'about',          to: 'static_pages#about', via: 'get'
  match 'contact',        to: 'static_pages#contact', via: 'get'
  match 'contact_send',   to: 'static_pages#contact_send', via: 'post'
  match 'charity',        to: 'static_pages#charity', via: 'get'
  match 'donations',      to: 'donations#new', via: 'get'

  # Sessions
  match 'signin', to: 'sessions#new', via: 'get'
  match 'signout', to: 'sessions#destroy', via: 'delete'

  # Resources
  resources :members do
    get :autocomplete, :on => :collection
    get :import_form, :on => :collection
    post :import, :on => :collection
  end

  resources :jobs
  resources :events
  resources :news
  resources :daggers

  match 'the-dagger', to: 'daggers#index', via: 'get'

  resources :sessions, only: [:new, :create, :destroy]
  
  resources :donations

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
