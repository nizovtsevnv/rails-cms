Cms::Application.routes.draw do
  root :to => 'pages#show', :name => nil

  get 'cms' => 'cms#show'
  get 'pages' => 'pages#index'
  get 'pages/:name' => 'pages#show', :as => :page, :constraints => { :name => /.+/ }

  namespace :api do
    resources :activities
    resources :locales
    resources :users

    namespace :content do
      resources :pages
      resources :uploads
      resources :widgets
    end
  end
end
