Rails.application.routes.draw do



  resources :events, only: [:index, :new, :create, :edit, :update, :show] do
    member do
      post 'assign_data_form', as: :assign_data_form
      delete 'remove_data_form_entity/:entity_id', to: 'events#remove_data_form_entity', as: :remove_data_form_entity
    end
  end




  resources :data_forms, only: [:index, :new, :create, :edit, :update]

  match '*all', to: proc { [204, {}, ['']] }, via: :options

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }




  # INDIVIDUAL URLS

  # form_responses_controller
  get '/:event_id/:data_form_entity_id/fill-form', to: 'form_responses#fill_form'
  post '/:event_id/:data_form_entity/response', to: 'form_responses#submit_form', as: :submit_form_response



  root "application#hello_gdg"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
