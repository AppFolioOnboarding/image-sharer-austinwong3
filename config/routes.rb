Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'images#index'
  get 'tags/:tag', to: 'images#index', as: :tag
  resources :images, except: %i[edit update]
end
