class DataFormEntitiesController < ApplicationController
  # before_action :set_kommunity
  before_action :authenticate_user!
  before_action :set_event_data_form_entity_group, only: [:form_responses, :form_responses_data]
  before_action :set_page_numbers, only: [:form_responses, :form_responses_data]
  before_action :access_allowed?



  # get the list of all entries filled for an event
  def form_responses
    @registration_types = RegistrationType.all
    @selected_status = params[:registration_status]
    @entry_passes = @edfeg.event.event_entry_passes.select(:id)
  end




  def form_responses_data

    if !params[:registration_status].blank? && params[:registration_status] != 'all'

      @responses = @edfeg.data_form_entity_response_groups.where('registration_status_id = ?', params[:registration_status].to_i).order(:created_at).offset(@count * (@page - 1)).limit(@count)

    else
      @responses = @edfeg.data_form_entity_response_groups.order(:created_at).offset(@count * (@page - 1)).limit(@count)

    end
    @selected_status = params[:registration_status]


    @registration_types = RegistrationType.all
    @entry_passes = @edfeg.event.event_entry_passes.where(user_id: @responses.map(&:user_id))


    @pending_data = @responses.length == @count ? true : false



  end




  private

  def set_event_data_form_entity_group
    @edfeg = EventDataFormEntityGroup.includes(data_form_entities: {data_form: {questions: [:question_choices, :data_form_entity_response_values]}}).find(params[:event_data_form_entity_group_id].to_i)
    RolePermission.event = @edfeg.event

  end

  def set_page_numbers
    @page = params[:page].blank? ? 1 : params[:page].to_i
    @count = params[:count].blank? ? 20 : params[:count].to_i
  end

end