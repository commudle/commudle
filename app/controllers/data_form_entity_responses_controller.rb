class DataFormEntityResponsesController < ApplicationController
  before_action :set_kommunity
  before_action :authenticate_user!
  before_action :set_data_form_entity, except: [:update_registration_status]



  # update or fill a data form for an event
  def fill_form

    # check if there is another user in the params
    if(params[:edit_user_id] )

    existing_response = DataFormEntityResponse.joins(:data_form_entity_response_group).includes(data_form_entity: {data_form: {questions: :question_type}}, data_form_entity_response_values: :question).where(data_form_entity_response_groups: {user_id: current_user.id}).last

    @existing_response = Hash.new
    if existing_response
      @existing_response = existing_response.get_response_hash
    end


  end


  def submit_form

    DataFormEntityResponse.create_or_find_user_response(@data_form_entity, current_user, params[:data_form_entity_response])

  end



  private

  def set_data_form_entity
    # @event = Event.friendly.find(params[:event_id])

    @data_form_entity = DataFormEntity.find(params[:data_form_entity_id])

  end



end