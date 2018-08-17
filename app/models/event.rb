class Event < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  belongs_to :kommunity
  belongs_to :user
  belongs_to :event_status

  has_many :event_data_form_entity_groups


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



end
