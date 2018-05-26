Rails.application.routes.draw do

  devise_scope :user do
    devise_for :users, path: '', path_names: { edit: 'edit_profile', sign_in: 'sign_in', sign_out: 'logout', sign_up: 'sign_up' }
    authenticated :user do
      root  'dashboard#index'
      mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
      get '*path' => redirect('/')
    end
    unauthenticated do
      #si se desea tener una pagina principal, a modo que el index no sea el login
      #root 'home#index'
      root to: 'devise/sessions#new'
    end
    get '*path' => redirect('/404')
  end
end
