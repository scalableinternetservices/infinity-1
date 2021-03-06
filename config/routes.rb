Rails.application.routes.draw do

  resources :blogs do
    resources :blog_comments, :only => [:create]
  end

  resources :users do
    resources :blog_comments, :only => [:create]
  end

  get '/categories/edit_categories', to: 'categories#edit_categories'
  get '/categories/submit_categories', to: 'categories#submit_categories'

  get '/cities/search', to:  'cities#search'

  resources :cities do
    resources :notes, :only => [:create]
  end

  resources :notes do
    resources :comments, :only => [:create]
  end

  resources :categories
  devise_for :users, :path_prefix => 'd'
  get '/users/categories', to: 'users#show_categories'
  resources :users, :only => [:show]

  devise_scope :user do
    authenticated :user do
      root 'footprints#index', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'footprints#index',  as: :footprint
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
