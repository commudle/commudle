module RolePermission
  extend ActiveSupport::Concern

  # included do
  #   before_action :user_signed_in?, unless: :devise_controller?
  # #   before_action :allowed?, unless: :devise_controller?
  # end

  thread_mattr_accessor :event


  # always define both direct and conditional permissions
  def permissions
    event = RolePermission.event
    {
        home: {
            all: [:home],
        },
        events: {
          all: [:index, :show],
          organizer: (
          [:new, :create] + ([:edit, :update, :update_event_status] if (!event.blank? && current_user.role?(:organizer, event.kommunity_id))).to_a
          )
        },
        data_form_entities: {
            organizer: (
            ([:form_responses] if (!event.blank? && current_user.role?(:organizer, event.kommunity_id)) ).to_a
            )
        }

    }
  end


  def has_permission(controller = nil, action = nil)
    controller = controller.blank? ? controller_name : controller
    action = action.blank? ? action_name : action

    controller_permissions = permissions[controller.to_sym]
    roles = user_signed_in? ? (current_user.user_roles.pluck(:name).map &:to_sym) : []
    roles << :all

    if (controller_permissions)
      available_permissions = controller_permissions.keys & roles
      if !available_permissions.empty?

        actions = []
        available_permissions.each do |ap|

          actions << controller_permissions[ap.to_sym]
        end
        actions.flatten!


        if actions.include?(action.to_sym)
          return true

        end
      end
    end
    return false
  end


  def allowed?
    if(!has_permission)
      return head 403
    end


  end



  def allowed_view?(controller, action)
    if(has_permission(controller, action))
      return true
    end
    return false
  end


end