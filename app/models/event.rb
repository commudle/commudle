class Event < ApplicationRecord
  # extend FriendlyId
  # friendly_id :name, use: :slugged

  belongs_to :kommunity
  belongs_to :user
  belongs_to :event_status

  has_many :event_data_form_entity_groups
  has_many :event_entry_passes


  before_save :create_log, if: :will_save_change_to_event_status_id?



  def create_log(current_user = nil)
    current_user = CurrentAccess.user.blank? ? current_user : CurrentAccess.user
    if current_user

      EventStatusLog.create(
                        event: self,
                        user: current_user,
                        event_status: self.event_status
      )

    else
      return "Event Status Change Log Not Created"

    end
  end


  def self.upcoming(community_id = nil)

    if(community_id.blank?)
      return Event.joins(:event_status, :kommunity).where(
                      "event_statuses.name = ?",
                      NameValues::EventStatusType::ANNOUNCED
      ).order("start_time asc")
    else
      return Event.joins(:event_status).where(
          "event_statuses.name = ? and kommunity_id = ?",
          NameValues::EventStatusType::ANNOUNCED, community_id
      ).order("start_time asc")
    end

  end

  # change this function to permitted forms
  # send if a user has already filled a form along with the list of permitted forms
  def open_forms

    open_forms = []
    self.event_data_form_entity_groups.each do |edfeg|
      edfeg.data_form_entities.where(visibility: :open).each do |dfe|
        open_forms << dfe
      end
    end

    open_forms

  end


  def start_time
    self[:start_time].in_time_zone(self.timezone)
  end


  def end_time
    self[:end_time].in_time_zone(self.timezone)
  end



end
