Rails.application.routes.draw do


devise_scope :user do
    get "/sign_in" => "devise/sessions#new"
    get "/sign_up" => "devise/registrations#new", as: "new_user_registration"
    get "/users" => "devise/registrations#new"
    delete "/logout" => "devise/sessions#destroy"
    get "/reset_password" => "devise/passwords#new"
    get "/users/password" => "devise/passwords#new"
  
    authenticated :user do
    root  'dashboard#index'
    mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
        resources :profile, as: :users, only: [:show, :update]
    get '*path' => redirect('/')
  end
  unauthenticated do
     root 'devise/sessions#new' , as: :unauthenticated_root
  end
  get '*path' => redirect('/404')
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
   devise_for :users
   end
end
