module RolePermission
  extend ActiveSupport::Concern

  included do
    # before_action :authenticate_user!, unless: :devise_controller?
    before_action :check_permission, unless: :devise_controller?
  end


  # always define both direct and conditional permissions
  def permissions(object)
    current_user = User.first
    {
        home: {
            all: [:home],
        },
        events: {
          all: [:index, :show],
          organizer: (
          [:new, :create] + ([:edit, :update, :update_event_status] if (current_user.role?(:organizer, object.kommunity_id))).to_a
          )
        }

    }
  end


  def allowed?(object)
    controller_permissions = permissions(object)[controller_name.to_sym]
    roles = current_user.user_roles.pluck(:name).map &:to_sym
    roles << :all

    available_permissions = controller_permissions.keys & roles
    if !available_permissions.empty?
      # actions = []
      # (controller_permissions.keys & roles).each { |x| actions | controller_permissions[x] }
      actions = []
      available_permissions.each do |ap|
        actions.flatten!
        actions << controller_permissions[ap.to_sym]
      end


      head 403 if !actions.include?(action_name.to_sym)
    else
      head 403
    end
  end


end