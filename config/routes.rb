Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'gallery_analytics#home', as: :home
  post 'gallery_analytics/parse_gallery_log', as: :parse_gallery_log
  resources :gallery_analytics
end
