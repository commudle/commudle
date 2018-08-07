class EventStatusLog < ApplicationRecord
  belongs_to :event
  belongs_to :user
  belongs_to :event_status
end
