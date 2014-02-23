Ceotalk::Application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks", registrations: "users/registrations" }
  ActiveAdmin.routes(self)

  resources :users do
    get 'me', on: :collection, :as => "profile"
    get 'me/favorites', on: :collection, :as => "favorites", controller: :likes, action: :list_favorites
  end
  resources :professionals
  resources :talks do
    resources :comments
  end
  resources :problems do
    resources :comments
  end

  get 'posts/wordpress/:id', :as => "wordpress_post", action: :wordpress, controller: :posts

  resources :companies do
  end

  resources :open_questions do
    resources :comments
  end

  post "open_questions/:id/like", :as => "like_open_question", action: :like, controller: :likes, class: "OpenQuestion"
  post "open_questions/:id/favorite", :as => "favorite_open_question", action: :favorite, controller: :likes, class: "OpenQuestion"

  post "companies/:id/like", :as => "like_company", action: :like, controller: :likes, class: "Company"
  post "companies/:id/favorite", :as => "favorite_company", action: :favorite, controller: :likes, class: "Company"

  post "problems/:id/like", :as => "like_problem", action: :like, controller: :likes, class: "Problem"
  post "problems/:id/favorite", :as => "favorite_problem", action: :favorite, controller: :likes, class: "Problem"

  post "talks/:id/like", :as => "like_talk", action: :like, controller: :likes, class: "Talk"
  post "talks/:id/favorite", :as => "favorite_talk", action: :favorite, controller: :likes, class: "Talk"

  post "professionals/:id/like", :as => "like_professional", action: :like, controller: :likes, class: "Professional"
  post "professionals/:id/favorite", :as => "favorite_professional", action: :favorite, controller: :likes, class: "Professional"

  post "comments/:id/like", :as => "like_commnet", action: :like, controller: :likes, class: "Comment"

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'

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
