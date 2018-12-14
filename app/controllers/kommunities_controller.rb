class KommunitiesController < ApplicationController
  before_action :authenticate_user!, except: [:show]


  def show
    @events = Event.where(kommunity_id: @kommunity.id)

    @upcoming_events = Event.includes(event_data_form_entity_groups: :data_form_entities).upcoming(kommunity_id: @kommunity.id)
    @recent_past_events = Event.includes(event_data_form_entity_groups: :data_form_entities).recent_past(kommunity_id: @kommunity.id)

  end

  def new
    @kommunity = Kommunity.new
  end


  def create
    kommunity = Kommunity.new(kommunity_params)
    kommunity.user = current_user
    kommunity.save

    # we will make an autocomplete for assigning organizers to the community
    # UserRolesUser.create(user: current_user, kommunity: kommunity, user_role: UserRole.find_by_name(NameValues::UserRoleType::ORGANIZER))

    redirect_to kommunity_show_path(kommunity.slug)

  end


  def edit

  end


  def update

    @kommunity.update(kommunity_params)
    redirect_to kommunity_show_path(@kommunity.slug)
  end


  private

  def kommunity_params

    params.require(:kommunity_form).permit(:name, :about, :logo_image, :mini_description)
  end



end