Rails.application.routes.draw do
  devise_scope :user do
    devise_for :users,
               path: '', path_names: {
                 sign_in: 'sign_in',
                 sign_out: 'logout'
               }
  end

  devise_scope :doctor do
    devise_for :doctors,
               path: '/doctors', path_names: {
                 sign_in: 'sign_in',
                 sign_out: 'logout'
               }
  end

  authenticated :doctor do
    resources :doctors, controller: 'doctors' do
      resources :time_slot
      resources :doctor_patients
      resources :prescription
      get 'prescription_pdf/:id', to: 'prescription#prescription_pdf', as: 'prescription_pdf'
    end
    root to: 'appointments#index'
  end

  resources :appointments do
    collection do
      scope controller: :appointments do
          get 'doctor_specialty/:specialty_id' => :doctor_specialty, as: 'doctor_specialty'
          get 'availability_slot/:time_slot_id/:appointment_date' => :availability_slot, as: 'availability_slot'
          get 'get_date_range/:appointment_date' => :get_date_range, as: 'get_date_range'
      end
      resources :medical_card do
        resources :medical_history
      end
    end
  end

  authenticated :user do
    # mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
    resources :users
    resources :doctors
    get 'user_prescriptions/:user_id', to: 'user_prescriptions#index', as: 'user_prescription'
    namespace :admin do
      scope controller: :dashboard do
        get 'users' => :index, as: 'dashboard_users'
        get 'doctors' => :index_doctors , as: 'dashboard_doctors'
      end
      resources :specialties
    end
    root to: 'home#index'
    get '*path' => redirect('/')
  end

  root to: 'home#unregistered'
  get '*path' => redirect('/404')
end
