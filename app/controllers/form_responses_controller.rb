class FormResponsesController < ApplicationController
  before_action :authenticate_user!
  before_action :set



  def fill_form

    existing_response = @data_form_entity.form_responses.find_by(user_id: current_user.id)

  end


  def submit_form

  end


  private

  def set_event_and_data_form_entity
    @event = Event.friendly.find(params[:event_id])

    @data_form_entity = DataFormEntity.friendly.find(params[:data_form_entity_id])

  end



end