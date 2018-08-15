Rails.application.routes.draw do



  resources :events, only: [:index, :new, :create, :edit, :update, :show] do
    member do
      post 'assign-data-form',
           to: 'events#assign_data_form',
           as: :assign_data_form


      delete 'remove-data-form-entity/:entity_id',
             to: 'data_form_entities_events#remove_data_form_entity',
             as: :remove_data_form_entity


      put 'update-event-status',
          to: 'events#update_event_status',
          as: :update_event_status


    end
  end


  resources :data_forms, :path => 'data-forms', only: [:index, :new, :create, :edit, :update]


  match '*all', to: proc { [204, {}, ['']] }, via: :options

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }




  # INDIVIDUAL URLS

  # data_form_entity_responses_controller
  get '/:event_id/:data_form_entity_id/fill-form',
      to: 'data_form_entity_responses#fill_form',
      as: :fill_form_response


  post '/:event_id/:data_form_entity_id/response',
       to: 'data_form_entity_responses#submit_form',
       as: :submit_form_response

  put 'form-responses/:id/update-registration_status',
      to: 'data_form_entity_responses#update_registration_status',
      as: :update_response_registration_status



  # data_form_entities_controller
  get '/:event_id/:data_form_entity_id/form-responses',
      to: 'data_form_entities#form_responses',
      as: :form_responses


  put '/:event_id/:data_form_entity_id/change-responses-registration_type',
      to: 'data_form_entities#change_responses_registration_type',
      as: :change_responses_registration_type



  root "application#hello_gdg"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
