Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  root "high_voltage/pages#show", id: "home"
  get :services, to: "high_voltage/pages#show", id: "services"
  get :work, to: "high_voltage/pages#show", id: "work"
  get :about, to: "high_voltage/pages#show", id: "about"
  get :blog, to: "high_voltage/pages#show", id: "blog"
  get :resume, to: "high_voltage/pages#show", id: "resume"
  get :contact, to: "high_voltage/pages#show", id: "contact"

  get :start, to: "inquiries#new", as: :start_project
  post :inquiries, to: "inquiries#create"
  get "start/thanks", to: "inquiries#thank_you", as: :inquiry_thank_you

  namespace :admin do
    resources :inquiries, only: [ :index, :show ]
  end
end
