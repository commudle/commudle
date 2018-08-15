class DataFormEntityResponsesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event_and_data_form_entity, except: [:update_registration_status]
  before_action :set_data_form_entity_response, only: [:update_registration_status]


  # update or fill a data form for an event
  def fill_form

    existing_response = @data_form_entity.data_form_entity_responses.includes(data_form_entity: {data_form: {questions: :question_type}}, data_form_entity_response_values: :question).find_by(user_id: current_user.id)
    @existing_response = Hash.new
    if existing_response
      @existing_response = existing_response.get_response_hash
      puts(@existing_response)
    end
  end


  def submit_form

    DataFormEntityResponse.create_or_find_user_response(@data_form_entity, current_user, params[:data_form_entity_response])

  end


  def update_registration_status
    @dfe_response.registration_status = RegistrationStatus.find(params[:registration_status])

    @dfe_response.save


  end


  private

  def set_event_and_data_form_entity
    @event = Event.friendly.find(params[:event_id])

    @data_form_entity = DataFormEntity.friendly.find_by(slug: params[:data_form_entity_id], entity: @event)

  end

  def set_data_form_entity_response
    @dfe_response = DataFormEntityResponse.find(params[:id])
  end



end