ActionController::Routing::Routes.draw do |map|
  map.resources :pages
  map.resources :revisions
  map.resources :people

  map.root         :controller => 'pages',  :action => 'show', :page_title => 'Home_Page'  

  map.signin       'signin',              :controller => 'people', :action => 'signin'
  map.signout      'signout',             :controller => 'people', :action => 'signout'

  map.connect      'pages.:format',        :controller => 'pages',  :action => 'index'  
  map.connect      'revisions.:format',    :controller => 'revisions',  :action => 'index'  
  
  map.page_base    ':page_title',         :controller => 'pages',  :action => 'show'
  map.connect      ':page_title.atom',    :controller => 'pages',  :action => 'history', :format => 'atom'  
  map.connect      ':page_title.rss',     :controller => 'pages',  :action => 'history', :format => 'rss'  
  map.connect      ':page_title.:format', :controller => 'pages',  :action => 'show'  

  map.page_edit    ':page_title/edit',     :controller => 'pages',  :action => 'edit'

  map.page_history ':page_title/history',  :controller => 'pages',  :action => 'history'
  map.connect      ':page_title/history.:format',  :controller => 'pages',  :action => 'history'

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
