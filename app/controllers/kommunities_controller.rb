class KommunitiesController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :access_allowed?, unless: :devise_controller?


  def show
    @events = Event.where(kommunity_id: @kommunity.id)
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
    @kommunity = Kommunity.friendly.find(params[:id])

  end


  def update
    @kommunity = Kommunity.friendly.find(params[:id])
    @kommunity.update(kommunity_params)
    redirect_to kommunity_show_path(@kommunity.slug)
  end


  private

  def kommunity_params
    params.require(:kommunity).permit(:name, :about, :logo_image)
  end



end