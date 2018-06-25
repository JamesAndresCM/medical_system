Rails.application.routes.draw do
  devise_scope :user do
    devise_for :users,
               path: '', path_names: { edit: 'edit_profile',
                                       sign_in: 'sign_in',
                                       sign_out: 'logout',
                                       sign_up: 'sign_up' }
  end

  authenticated :user do
    mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
    get '*path' => redirect('/')
  end

  root to: 'home#index'
  get '*path' => redirect('/404')
end
