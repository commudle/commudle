class DataFormEntitiesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event_and_data_form_entity
  before_action :set_registration_type, only: [:change_responses_registration_type]


  # get the list of all entries filled for an event
  def form_responses
    @form_responses = DataFormEntityResponseValue.joins(
        question: :question_type,
        data_form_entity_response: :data_form_entity
    ).where('data_form_entity_responses.data_form_entity_id = ?', @data_form_entity.id).order('questions.created_at')

    @registration_types = RegistrationType.all


  end


  def change_responses_registration_type

    @data_form_entity.registration_type = @registration_type
    @data_form_entity.save

    return redirect_back fallback_location: root_path


  end




  private

  def set_event_and_data_form_entity
    @event = Event.friendly.find(params[:event_id])

    @data_form_entity = DataFormEntity.includes(data_form: {questions: [:question_choices, :data_form_entity_response_values]}).friendly.find_by(slug: params[:data_form_entity_id], entity: @event)

  end


  def set_registration_type
    @registration_type = RegistrationType.find(params[:registration_type])

  end



end