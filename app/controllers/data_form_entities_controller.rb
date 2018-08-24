class DataFormEntitiesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event_data_form_entity_group, only: [:form_responses]
  before_action :set_registration_type, only: [:change_responses_registration_type]


  # get the list of all entries filled for an event
  def form_responses
    @form_responses = DataFormEntityResponseValue.joins(
        question: :question_type,
        data_form_entity_response: {data_form_entity: :event_data_form_entity_response_group}
    ).where('event_data_form_entity_response_groups.id = ?', @edfeg.id).order('questions.created_at')

    @registration_types = RegistrationType.all
    @entry_passes = @edfeg.event.event_entry_passes


  end


  def change_responses_registration_type

    @data_form_entity.registration_type = @registration_type
    @data_form_entity.save

    return redirect_back fallback_location: root_path


  end




  private

  def set_event_data_form_entity_group
    @edfeg = EventDataFormEntityGroup.includes(data_form_entities: {data_form: {questions: [:question_choices, :data_form_entity_response_values]}}).find(params[:event_data_form_entity_group_id])

  end


  def set_registration_type
    @registration_type = RegistrationType.find(params[:registration_type])

  end



end