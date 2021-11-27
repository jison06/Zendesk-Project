Rails.application.routes.draw do
  root 'tickets#index'
  get 'tickets/index', defaults: { format: :json }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
