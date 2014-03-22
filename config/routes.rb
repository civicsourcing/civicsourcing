CivicSourcing::Application.routes.draw do
  class FormatTest
    attr_accessor :mime_type

    def initialize(format)
      @mime_type = Mime::Type.lookup_by_extension(format)
    end

    def matches?(request)
      request.format == mime_type
    end
  end

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :badges, constraints: FormatTest.new(:json)
      resources :comments, constraints: FormatTest.new(:json)
      resources :communities, constraints: FormatTest.new(:json)
      resources :events, constraints: FormatTest.new(:json)
      resources :feeds, constraints: FormatTest.new(:json)
      resources :initiatives, constraints: FormatTest.new(:json)
      resources :memberships, constraints: FormatTest.new(:json)
      resources :membership_requests, constraints: FormatTest.new(:json)
      resources :membership_request_responses, constraints: FormatTest.new(:json)
      resources :posts, constraints: FormatTest.new(:json)
      resources :uploads, only: [:create, :show]
      resources :users, constraints: FormatTest.new(:json)
      devise_for :users
      resources :votes, constraints: FormatTest.new(:json)
      resources :workrooms, constraints: FormatTest.new(:json)
      get 'register', to: 'users#new', constraints: FormatTest.new(:json)
      get 'dashboard', to: 'dashboard#index', constraints: FormatTest.new(:json)
    end
  end

  get '*foo', :to => 'ember#index', :constraints => FormatTest.new(:html)
  get '/', :to => 'ember#index', :constraints => FormatTest.new(:html)

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
