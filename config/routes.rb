Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'home#index'

  devise_for :users, controllers: { sessions: "user/sessions", passwords: "user/passwords" },
                     path: "/", path_names: {
                      sign_in:      "login",
                      sign_out:     "logout"
                     }
  devise_scope :user do
    get     "register",           to: "user/registrations#new"
    post    "register/step1",     to: 'user/registrations#step1',   as: :step1
    post    "registration",       to: "user/registrations#create"
    get     "register/step2",     to: 'user/registrations#step2',   as: :step2
    get     "register/step3",     to: 'user/registrations#step3',   as: :step3
    patch   "update_info",        to: "user/registrations#update_info"
    delete  "remove_avatar",      to: 'user/registrations#remove_avatar'
  end

  match "/profile/update",           to: "profile#update", via: [:patch, :post], as: :update_profile
  get   "/profile(/:id)",           to: "profile#profile", as: :profile

  resources :teachers, only: [:index, :show]
  get   "teacher_stuff",      to: "teachers#teacher_stuff"
  post  "teacher_stuff",      to: "teachers#create_teacher_stuff"
  get   "lesson",             to: "teachers#new_lesson"
  post  "create_lesson",      to: "teachers#create_lesson"
  post  "create_review",      to: 'teachers#create_review'

  post  "/request_class",      to: "class_rooms#request_class"
  post  "/check_request",      to: "teachers#check_request",     as: :check_request

  get "/about", to: "home#about", as: :about
  get "/contact", to: "home#contact", as: :contact
  get "/terms", to: "home#terms", as: :terms
  get "/privacy", to: "home#privacy", as: :privacy

  get  "/events", to: 'teachers#events'
  post "/add-available",  to: 'teachers#add_available', as: :add_available
  post "/remove-available",  to: 'teachers#remove_available', as: :remove_available

  get "/demo",  to: 'class_rooms#demo'
  get   "/class-chat/:id",                      to: 'class_rooms#class_chat', as: :class_chat
  post  "/class_chat/:class_room_id/messages",  to: 'messages#create',        as: :messages

  # Payment routes
  post "express_checkout",    to: 'credits#express_checkout', as: :express_checkout
  get "confirm/(:param)",     to: 'credits#confirm', as: :confirm
  post "express",             to: 'credits#express'
  post "credits",             to: 'credits#create'
  patch "transfer_credit",    to: 'credits#transfer_to_teacher', as: :transfer_credit
  patch "redeem",             to: 'credits#redeem', as: :redeem
  
  resources :contact_forms, only: [:create]
end
