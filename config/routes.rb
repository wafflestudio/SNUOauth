SNUOauth::Application.routes.draw do
  devise_for :admins, :path => "admin", :path_names => {:sign_up => "signup", :sign_in => "signin", :sign_out => "signout"}, :skip => [:passwords, :registrations]
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'
  devise_for :users, :controllers => {:omniauth_callbacks => "users/omniauth_callbacks"}, :skip => [:passwords, :registrations]

  root 'main#home'
  get 'api' => "main#api"
  get 'about' => "main#about"
  get 'contact' => "main#contact"
  get 'facebook' => "main#facebook"

  resources :apps, :except => [:show]
  resources :posts, :only => [:index, :new, :create, :destroy]
  resources :comments, :only => [:new, :create, :destroy]
  
  scope "api" do
    get 'example' => 'api#example'
    get 'authorize' => 'api#authorize'
    get 'account/info' => 'api#account_info'
    get ':client_id' => 'apps#shorten_url', :as => "shorten_url"
  end
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
