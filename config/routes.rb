Rails.application.routes.draw do



  resources :events, only: [:index, :new, :create, :edit, :update, :show] do
    member do
      post 'assign-data-form',
           to: 'event_data_form_entity_groups#assign_data_form_entity',
           as: :assign_data_form

      post 'create-form-set',
           to: 'event_data_form_entity_groups#create',
           as: :create_form_set

      delete 'destroy-form-set',
             to: 'event_data_form_entity_groups#destroy',
             as: :destroy_form_set


      delete 'remove-data-form-entity',
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
  get 'fill-form',
      to: 'data_form_entity_responses#fill_form',
      as: :fill_form_response


  post 'response',
       to: 'data_form_entity_responses#submit_form',
       as: :submit_form_response

  put 'form-responses/update-registration_status',
      to: 'data_form_entity_response_groups#update_registration_status',
      as: :update_response_registration_status


  get 'update-rsvp',
      to: 'data_form_entity_response_groups#update_rsvp',
      as: :update_rsvp



  # data_form_entities_controller
  get 'form-responses',
      to: 'data_form_entities#form_responses',
      as: :form_responses


  put 'change-responses-registration_type',
      to: 'data_form_entities#change_responses_registration_type',
      as: :change_responses_registration_type


  #event_communications_mailer
  resources :event_communication_mailers, path: "event-communication-mailers" do
    collection do
      get :data_form_entity_response_group_rsvp_email, path: "user-rsvp-email"
      post :send_data_form_entity_response_group_rsvp_email, path: "send-user-rsvp-email"
      get :event_data_form_entity_group_rsvp_email, path: "event-users-rsvp-email"
      post :send_event_data_form_entity_group_rsvp_email, path: "send-event-users-rsvp-email"
      get :data_form_entity_response_group_entry_pass_email, path: "user-entry-pass-email"
      post :send_data_form_entity_response_group_entry_pass_email, path: "send-user-entry-pass-email"
      get :event_data_form_entity_group_entry_pass_email, path: "event-users-entry-pass-email"
      post :send_event_data_form_entity_group_entry_pass_email, path: "send-event-users-entry-pass-email"
    end
  end



  root "application#hello_gdg"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
