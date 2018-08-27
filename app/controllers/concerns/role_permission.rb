module RolePermission
  extend ActiveSupport::Concern

  # included do
  #   before_action :user_signed_in?, unless: :devise_controller?
  # #   before_action :allowed?, unless: :devise_controller?
  # end

  thread_mattr_accessor :event, :kommunity


  # always define both direct and conditional permissions
  def permissions
    event = RolePermission.event
    kommunity = RolePermission.kommunity


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
            [:form_responses] if (!event.blank? && current_user.role?(:organizer, event.kommunity_id))
            ).to_a
        },

        data_form_entity_response_groups: {
            organizer: (
            [:update_registration_status] if (!event.blank? && current_user.role?(:organizer, event.kommunity_id))
            ).to_a
        },

        event_communication_mailers: {
            organizer: (
            (
            [
              :data_form_entity_response_group_rsvp_email,
              :send_data_form_entity_response_group_rsvp_email,
              :event_data_form_entity_group_rsvp_email,
              :send_event_data_form_entity_group_rsvp_email,
              :data_form_entity_response_group_entry_pass_email,
              :send_data_form_entity_response_group_entry_pass_email,
              :event_data_form_entity_group_entry_pass_email,
              :send_event_data_form_entity_group_entry_pass_email] if (!kommunity.blank? && current_user.role?(:organizer, kommunity.id))).to_a
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