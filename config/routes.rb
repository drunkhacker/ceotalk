Ceotalk::Application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  devise_for :users, :controllers => { omniauth_callbacks: "users/omniauth_callbacks", registrations: "users/registrations",  passwords: "users/passwords", confirmations: 'users/confirmations'}
  devise_scope :user do
    get 'users/confirmation_sent', to: 'users/registrations#after_signup', as: :after_signup
    get 'users/reset_password_sent', to: 'users/passwords#after_sent'
    post "users/check_email", to: "users/registrations#check_email"
  end
  ActiveAdmin.routes(self)

  resources :users do
    get 'me', on: :collection, :as => "profile"
    get 'me/favorites', on: :collection, :as => "favorites", controller: :likes, action: :list_favorites
  end
  resources :professionals do
    resources :comments
  end
  resources :talks do
    resources :comments
    get 'page', on: :collection, :as => "page"
  end
  resources :problems do
    resources :comments
  end

  resources :comments do
    resources :comments
  end
  post "comments/:id/like", :as => "like_comment", action: :like, controller: :likes, class: "Comment"

  get 'posts/wordpress/:id', :as => "wordpress_post", action: :wordpress, controller: :posts

  resources :companies do
    resources :comments
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

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'

  # for footer
  get 'info/company_intro' => 'home#company_intro'
  get 'info/agreement' => 'home#agreement'
  get 'info/privacy_policy' => 'home#privacy_policy'
  get 'info/email_deny' => 'home#email_deny'
  get 'info/map' => 'home#map'
  get 'info/ceomba_intro' => 'home#ceomba_intro'

  #for search
  post "search", :controller => "home", :action => "search"
  get "search/page", :controller => "home", :action => "search_page"

end
