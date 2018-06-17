Rails.application.routes.draw do

  get 'data_forms/index'

  get 'data_forms/new'

  get 'data_forms/create'

  get 'data_forms/edit'

  get 'data_forms/update'


  resources :data_forms, only: [:index, :new, :create, :edit, :update]

  match '*all', to: proc { [204, {}, ['']] }, via: :options

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }


  root "application#hello_gdg"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
