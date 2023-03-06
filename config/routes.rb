Rails.application.routes.draw do
  root "main#index"

  get 'main/index'
  get 'reports/index'
  get 'reports/report_by_category'
  get 'reports/report_by_dates'
  get 'reports/report'

  resources :operations
  resources :categories
  resources :reports
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
