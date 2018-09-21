class UserEventLocation < ApplicationRecord
  belongs_to :user
  belongs_to :event_location

  default_scope { order(preference_order: :asc, created_at: :asc) }


  def self.set_preference(user, event_locations)

    event_locations.each do |key, val|
      ull = UserEventLocation.find_or_create_by(
                           user: user,
                           event_location_id: val.to_i
                        ).update(
                              preference_order: key.to_i
                        )
    end

  end


  def self.preferred_location(user_id, event_id, preference_order)
    pref_location =  UserEventLocation.joins(:event_location).find_by(user_id: user_id, event_locations: {event_id: event_id}, preference_order: preference_order)

    if pref_location
      return pref_location.event_location_id
    else
      return nil
    end
  end

  # select or automatically create and select a location for an event for a user who has registered
  def self.select_location(dferg, event_location_id = nil)

    user_id = dferg.user_id
    event = dferg.event_data_form_entity_group.event

    all_event_locations = event.event_locations
    all_event_location_ids = all_event_locations.map(&:id)


    if (event_location_id.blank?)
      user_event_locations = UserEventLocation.joins(event_location: :event).where('user_event_locations.user_id = ? and events.id = ?', user_id, event.id)


      # user has not preferred any location for this event, then set the first location as the selected location

      # user has given preference, but we are yet to finalize a location for him/her, select the first one

      # user has selected a location and we have finalized a location for him/her

      if user_event_locations.blank?
        UserEventLocation.create(
            user_id: user_id,
            event_location_id: all_event_location_ids[0],
        ).update(
            is_selected: true
        )

      elsif !user_event_locations.blank?
        user_selected_location = user_event_locations.detect{|w|  w.is_selected == true}

        if user_selected_location.blank?
          user_event_locations.detect{|w|  w.preference_order == 1}.update(is_selected: true)
        end

      end

    end


    # check if the location exists for the event
    if (all_event_location_ids.include?(event_location_id.to_i))
      UserEventLocation.where(user: dferg.user).where('event_location_id != ?', event_location_id).update_all(is_selected: false)
      UserEventLocation.find_or_create_by(
          user_id: user_id,
          event_location_id: event_location_id,
      ).update(
          is_selected: true
      )

    end

  end

  def self.get_user_event_locations(user_id, event_id)
    UserEventLocation.joins(:event_location).where('event_locations.event_id = ? and user_id = ?', event_id, user_id)
  end


  # list of event locations in the order selected by the user
  def self.get_display_locations(dferg, event)
    user_preferred_locations = UserEventLocation.get_user_event_locations(dferg.user_id, event.id).to_set

    # TODO optimize the query
    elocations = Hash.new
    user_preferred_locations.each do |upl|
      elocations[upl.event_location.location_id] = {
          location: upl.event_location.location,
          event_location_id: upl.event_location_id,
          is_selected: upl.is_selected
      }
    end

    event.event_locations.each do |el|
      if (!elocations[el.location_id])
        elocations[el.id] = {
            location: el.location,
            event_location_id: el.id,
            is_selected: false
        }
      end

    end

    return elocations

  end


end
