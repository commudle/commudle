class UserEventLocation < ApplicationRecord
  belongs_to :user
  belongs_to :event_location

  default_scope { order(preference_order: :asc) }
end
