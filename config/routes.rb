Rails.application.routes.draw do


  resources :kommunities, only: [:new, :create, :edit, :update]

  scope ':kommunity' do

    get '/',
        to: 'kommunities#show',
        as: :kommunity_show

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


        get 'update-registration-status-counter',
            to: 'event_data_form_entity_groups#update_registration_status_counter',
            as: :update_registration_status_counter


        delete 'remove-data-form-entity',
               to: 'data_form_entities_events#remove_data_form_entity',
               as: :remove_data_form_entity

        post 'form/update-visibility',
            to: 'data_form_entities_events#update_visibility',
            as: :update_form_visibility


        put 'update-event-status',
            to: 'events#update_event_status',
            as: :update_event_status

        put 'update-header-image',
            to: 'events#update_header_image',
            as: :update_header_image


        get 'all-responses',
            to: 'events#all_responses',
            as: :all_responses

        resources :event_location_tracks, path: 'event-location-tracks', only: [:create, :destroy], shallow: true do
          resources :track_slots, path: 'track-slots', only: [:create, :destroy], shallow: true
        end


        resources :comments, only: [:create, :destroy], shallow: true do
          resources :comments, only: [:create, :destroy]
        end


      end

      resources :locations, only: [:create, :destroy]
    end

    resources :data_forms, path: 'data-forms', only: [:new, :create, :edit, :update]


    resources :event_entry_passes, path: 'event-entry-passes', only: [:create] do
      member do
        patch :toggle_attendance, as: 'toggle-attendance'
        patch :toggle_uninvited, as: 'toggle-uninvited'
      end

      collection do
        get :auto_attendance, as: 'auto-attendance'
        patch :mark_attendance, as: 'mark-attendance'
      end
    end




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


    # data_form_entity_responses_controller
    put 'user-event-locations/update-selected-location',
        to: 'user_event_locations#update_selected_location',
        as: :update_user_event_selected_location



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

        get :feedback_email, path: "feedback-email"
        post :send_feedback_email, path: "send-feedback-email"
      end
    end

  end







  match '*all', to: proc { [204, {}, ['']] }, via: :options

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }








  root "home#home"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
