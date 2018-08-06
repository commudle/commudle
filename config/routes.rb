Rails.application.routes.draw do



  resources :events, only: [:index, :new, :create, :edit, :update, :show] do
    member do
      post 'assign_data_form',
           as: :assign_data_form


      delete 'remove_data_form_entity/:entity_id',
             to: 'data_form_entities_events#remove_data_form_entity',
             as: :remove_data_form_entity

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



  root "application#hello_gdg"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
