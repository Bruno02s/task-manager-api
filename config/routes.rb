require 'api_version_constraint'

Rails.application.routes.draw do
  devise_for :users, only: [:sessions], controllers: { sessions: 'api/v1/sessions' }

  #Configuration for use Subdomain API
  #namespace :api, defaults: { format: :json }, constraints: { subdomain: 'api' }, path: '/' do

  #Using Heroku
  namespace :api, defaults: { format: :json }, path: '/' do
    namespace :v1, constraints: ApiVersionConstraint.new(version: 1),  path: '/' do
      resources :users, only: [:show, :create, :update, :destroy]
      resources :sessions, only: [:create, :destroy]
      resources :tasks, only: [:index, :show, :create, :update, :destroy]
    end

    namespace :v2, constraints: ApiVersionConstraint.new(version: 2, default: true),  path: '/' do
      mount_devise_token_auth_for 'User', at: 'auth'

      resources :users, only: [:show, :create, :update, :destroy]
      resources :sessions, only: [:create, :destroy]
      resources :tasks, only: [:index, :show, :create, :update, :destroy]
    end
  end

end