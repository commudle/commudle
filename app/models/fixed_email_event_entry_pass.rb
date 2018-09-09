class FixedEmailEventEntryPass < ApplicationRecord
  belongs_to :event_entry_pass
  belongs_to :fixed_email
end
