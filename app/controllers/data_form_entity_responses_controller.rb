class DataFormEntityResponsesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event_and_data_form_entity


  # update or fill a data form for an event
  def fill_form

    @existing_response = @data_form_entity.data_form_entity_responses.includes(data_form_entity: {data_form: {questions: :question_type}}, data_form_entity_response_values: :question).find_by(user_id: current_user.id)
    if @existing_response
      @existing_response = @existing_response.get_response_hash
    end
  end


  def submit_form

    DataFormEntityResponse.create_or_find_user_response(@data_form_entity, current_user, params[:data_form_entity_response])

  end


  private

  def set_event_and_data_form_entity
    @event = Event.friendly.find(params[:event_id])

    @data_form_entity = DataFormEntity.friendly.find_by(slug: params[:data_form_entity_id], entity: @event)

  end



end