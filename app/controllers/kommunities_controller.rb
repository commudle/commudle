class KommunitiesController < ApplicationController
  before_action :authenticate_user!

  def show
    @events = Event.where(kommunity_id: @kommunity.id)
  end

  def new

  end


  def create
    kommunity = Kommunity.new(kommunity_params)
    kommunity.user = current_user
    kommunity.save

    UserRolesUser.create(user: current_user, kommunity: kommunity, user_role: UserRole.find_by_name(NameValues::UserRoleType::ORGANIZER))


  end


  def edit

  end


  def update
    kommunity = @kommunity.update(kommunity_params)
  end


  private

  def kommunity_params
    params.require(:kommunity).permit(:name, :about)
  end



end