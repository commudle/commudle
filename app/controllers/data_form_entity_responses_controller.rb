class DataFormEntityResponsesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_data_form_entity, except: [:update_registration_status]
  before_action :set_data_form_entity_response, only: [:update_registration_status]


  # update or fill a data form for an event
  def fill_form

    existing_response = DataFormEntityResponse.joins(:data_form_entity_response_group).includes(data_form_entity: {data_form: {questions: :question_type}}, data_form_entity_response_values: :question).where(data_form_entity_response_groups: {user_id: current_user.id}).last

    @existing_response = Hash.new
    if existing_response
      @existing_response = existing_response.get_response_hash
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

  def set_data_form_entity
    # @event = Event.friendly.find(params[:event_id])

    @data_form_entity = DataFormEntity.find(params[:data_form_entity_id])

  end

  def set_data_form_entity_response
    @dfe_response = DataFormEntityResponse.find(params[:id])
  end



end