# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  resources :posts do
    resources :comments, module: :posts, except: %i[show] do
      resources :reactions, module: :comments, only: %i[create destroy]
    end
  end

  root 'posts#index'
end
