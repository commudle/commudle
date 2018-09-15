class DataFormEntityResponsesController < ApplicationController
  # before_action :set_kommunity
  before_action :authenticate_user!, except: [:fill_form]
  before_action :set_data_form_entity



  # update or fill a data form for an event
  def fill_form

    @existing_response = Hash.new

    if (user_signed_in?)
      existing_response = DataFormEntityResponse.joins(:data_form_entity_response_group).includes(data_form_entity: {data_form: {questions: :question_type}}, data_form_entity_response_values: :question).where(data_form_entity_response_groups: {user_id: current_user.id}).last


      if existing_response &&  !@for_other_user
        @existing_response = existing_response.get_response_hash
      end
    end

    @event = @data_form_entity.entity.event

    @ots = params[:ots].blank? ? '' : params[:ots]



  end



  def submit_form

    if (@data_form_entity.can_fill_event_form(current_user))

      if(user_signed_in? && !current_user.role?(:member, @kommunity.id))
        UserRolesUser.create(
            user: current_user,
            kommunity: @kommunity,
            user_role: UserRole.find_by_name(:member)
        )
      end

      dfer = DataFormEntityResponse.create_or_find_user_response(
          @data_form_entity,
          current_user,
          params[:data_form_entity_response],
          from_organizer = true
      )



      if (params[:ots] && params[:ots] == 'true')
        new_entry_pass = EventEntryPass.find_or_create(dfer.data_form_entity_response_group.event_data_form_entity_group.event, dfer.data_form_entity_response_group.user,  current_user, true, true, true)

      end

    else
      return error_response(
          ErrorNotification::ResponseTypes::HTML,
          ErrorNotification::ErrorCodes::UNAUTHORIZED,
          "Welcome to Kommunity! This form is closed! Please contact the organizers for more information!"
      )
    end



  end



  private

  def set_data_form_entity
    # @event = Event.friendly.find(params[:event_id])

    @data_form_entity = DataFormEntity.find(params[:data_form_entity_id])
    @for_other_user = (params[:for_other_user] == 'true')

  end




end